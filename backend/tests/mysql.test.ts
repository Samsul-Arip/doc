import { afterAll, describe, expect, it } from 'vitest';
import mysql from 'mysql2/promise';
import request from 'supertest';
import { createApp } from '../src/app.js';
import { MysqlInventoryRepository } from '../src/repository.js';
// Aktifkan hanya pada database latihan yang sudah diberi schema dan seed.
describe.skipIf(process.env.MYSQL_TEST !== '1')('Integrasi MySQL nyata', () => {
  const pool = mysql.createPool({
    host: process.env.DB_HOST ?? '127.0.0.1',
    port: Number(process.env.DB_PORT ?? 3306),
    user: process.env.DB_USER ?? 'root',
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME ?? 'masterclass',
    timezone: 'Z',
    dateStrings: true,
  });
  const app = createApp(
    new MysqlInventoryRepository(pool),
    async () => {
      await pool.query('SELECT 1');
    },
    [],
    true,
  );
  afterAll(async () => {
    await pool.end();
  });
  it('CRUD nyata, duplicate SKU, filter, dan literal SQL injection', async () => {
    const p = {
      name: 'Produk Uji',
      sku: `TEST-${Date.now()}`,
      categoryId: 1,
      price: 12.34,
      stock: 2,
    };
    const result = await request(app).post('/api/products').send(p).expect(201);
    const id = result.body.data.id;
    try {
      expect(result.body.data.price).toBe(12.34);
      await request(app).post('/api/products').send(p).expect(409);
      const list = await request(app)
        .get('/api/products')
        .query({ search: p.sku, categoryId: 1, limit: 1 })
        .expect(200);
      expect(list.body.meta.total).toBe(1);
      const injection = await request(app)
        .get('/api/products')
        .query({ search: "' OR 1=1 --" })
        .expect(200);
      expect(injection.body.data).toHaveLength(0);
      await request(app)
        .put(`/api/products/${id}`)
        .send({ ...p, price: 0, stock: 0 })
        .expect(200);
      await request(app)
        .put(`/api/products/${id}`)
        .send({ ...p, price: 0, stock: 0 })
        .expect(200);
      const detail = await request(app).get(`/api/products/${id}`).expect(200);
      expect(detail.body.data.stock).toBe(0);
    } finally {
      await request(app).delete(`/api/products/${id}`).expect(204);
    }
    await request(app).get(`/api/products/${id}`).expect(404);
  });
  it('melindungi foreign key pesanan dan kategori', async () => {
    await request(app).delete('/api/products/1').expect(409);
    await request(app)
      .post('/api/products')
      .send({
        name: 'x',
        sku: 'FK-TEST',
        categoryId: 2147483647,
        price: 1,
        stock: 0,
      })
      .expect(400);
  });
});
