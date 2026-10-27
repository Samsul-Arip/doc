import { beforeEach, describe, expect, it } from 'vitest';
import request from 'supertest';
import { createApp } from '../src/app.js';
import type { InventoryRepository } from '../src/repository.js';
import type { Product, ProductInput, ListInput } from '../src/validation.js';
// Fake ini hanya untuk HTTP/service; koneksi SQL diuji terpisah.
class MemoryRepository implements InventoryRepository {
  rows: Product[] = [];
  seq = 1;
  async list(q: ListInput) {
    const rows = this.rows
      .filter(
        (p) =>
          (!q.categoryId || p.categoryId === q.categoryId) &&
          `${p.name} ${p.sku}`.toLowerCase().includes(q.search.toLowerCase()),
      )
      .sort((a, b) => b.id - a.id);
    return {
      data: rows.slice((q.page - 1) * q.limit, q.page * q.limit),
      meta: {
        page: q.page,
        limit: q.limit,
        total: rows.length,
        totalPages: Math.ceil(rows.length / q.limit),
      },
    };
  }
  async find(id: number) {
    return this.rows.find((p) => p.id === id);
  }
  async create(p: ProductInput) {
    if (this.rows.some((row) => row.sku.toLowerCase() === p.sku.toLowerCase()))
      throw { code: 'ER_DUP_ENTRY' };
    if (p.categoryId !== 1) throw { code: 'ER_NO_REFERENCED_ROW_2' };
    const row = {
      ...p,
      id: this.seq++,
      createdAt: '2026-01-01T00:00:00Z',
      updatedAt: '2026-01-01T00:00:00Z',
    };
    this.rows.push(row);
    return row;
  }
  async update(id: number, p: ProductInput) {
    const row = await this.find(id);
    if (row) Object.assign(row, p);
    return row;
  }
  async delete(id: number) {
    const before = this.rows.length;
    this.rows = this.rows.filter((p) => p.id !== id);
    return before !== this.rows.length;
  }
  async categories() {
    return [{ id: 1, name: 'Elektronik' }];
  }
}
const input = {
  name: 'Keyboard',
  sku: 'KEY-01',
  categoryId: 1,
  price: 250000.25,
  stock: 5,
};
let repo: MemoryRepository;
beforeEach(() => {
  repo = new MemoryRepository();
});
const app = () => createApp(repo, async () => {}, [], true);
describe('Kontrak REST inventory', () => {
  it('menyelesaikan alur tambah, baca, ubah, dan hapus', async () => {
    const created = await request(app())
      .post('/api/products')
      .send(input)
      .expect(201);
    const id = created.body.data.id;
    expect(created.headers.location).toBe(`/api/products/${id}`);
    await request(app()).get(`/api/products/${id}`).expect(200);
    const changed = await request(app())
      .put(`/api/products/${id}`)
      .send({ ...input, stock: 0 })
      .expect(200);
    expect(changed.body.data.stock).toBe(0);
    await request(app()).delete(`/api/products/${id}`).expect(204);
    await request(app()).get(`/api/products/${id}`).expect(404);
  });
  it('membatasi pencarian, kategori dan pagination', async () => {
    await repo.create(input);
    await repo.create({ ...input, sku: 'MOU', name: 'Mouse' });
    const result = await request(app())
      .get('/api/products?limit=1&page=2&categoryId=1')
      .expect(200);
    expect(result.body.meta.total).toBe(2);
    expect(result.body.data[0].name).toBe('Keyboard');
    const search = await request(app())
      .get('/api/products?search=mouse')
      .expect(200);
    expect(search.body.data).toHaveLength(1);
  });
  it.each([
    { stock: -1 },
    { price: 1.001 },
    { categoryId: '1' },
    { name: ' ' },
    { sku: 'BAD SKU' },
    { price: 1e20 },
    { extra: true },
  ])('menolak input tidak valid %o', async (invalid) => {
    await request(app())
      .post('/api/products')
      .send({ ...input, ...invalid })
      .expect(400);
  });
  it.each([
    'page=0',
    'limit=101',
    'categoryId=x',
    'page=1.5',
    'search[x]=1',
    'unexpected=1',
  ])('menolak query %s', async (query) => {
    await request(app()).get(`/api/products?${query}`).expect(400);
  });
  it('mengembalikan 409 untuk SKU ganda dan 400 untuk kategori hilang', async () => {
    await repo.create(input);
    await request(app()).post('/api/products').send(input).expect(409);
    await request(app())
      .post('/api/products')
      .send({ ...input, sku: 'NEW', categoryId: 999 })
      .expect(400);
  });
  it('menangani health, readiness, kategori dan 404', async () => {
    await request(app()).get('/health').expect(200);
    await request(app()).get('/ready').expect(200);
    await request(app()).get('/api/categories').expect(200);
    await request(app()).get('/missing').expect(404);
    await request(app()).get('/api/products/abc').expect(400);
    await request(app()).put('/api/products/999').send(input).expect(404);
    await request(app()).delete('/api/products/999').expect(404);
  });
  it('menyembunyikan detail kegagalan database', async () => {
    repo.list = async () => {
      throw new Error('password=rahasia SQL internal');
    };
    const result = await request(app()).get('/api/products').expect(500);
    expect(JSON.stringify(result.body)).not.toContain('rahasia');
    await request(
      createApp(
        repo,
        async () => {
          throw Error('db');
        },
        [],
        true,
      ),
    )
      .get('/ready')
      .expect(503);
  });
  it('menolak JSON rusak', async () => {
    await request(app())
      .post('/api/products')
      .set('Content-Type', 'application/json')
      .send('{bad')
      .expect(400);
  });
});
