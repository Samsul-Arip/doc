import type { Pool, RowDataPacket, ResultSetHeader } from 'mysql2/promise';
import type {
  Category,
  Product,
  ProductInput,
  ListInput,
  ProductPage,
} from './validation.js';
export interface InventoryRepository {
  list(input: ListInput): Promise<ProductPage>;
  find(id: number): Promise<Product | undefined>;
  create(input: ProductInput): Promise<Product>;
  update(id: number, input: ProductInput): Promise<Product | undefined>;
  delete(id: number): Promise<boolean>;
  categories(): Promise<Category[]>;
}
const columns =
  'id, name, sku, category_id AS categoryId, price, stock, created_at AS createdAt, updated_at AS updatedAt';
function product(row: RowDataPacket): Product {
  return {
    id: row.id,
    name: row.name,
    sku: row.sku,
    categoryId: row.categoryId,
    price: Number(row.price),
    stock: row.stock,
    createdAt: new Date(
      String(row.createdAt).replace(' ', 'T') + 'Z',
    ).toISOString(),
    updatedAt: new Date(
      String(row.updatedAt).replace(' ', 'T') + 'Z',
    ).toISOString(),
  };
}
export class MysqlInventoryRepository implements InventoryRepository {
  constructor(private pool: Pool) {}
  async list(input: ListInput): Promise<ProductPage> {
    const where: string[] = [];
    const values: (string | number)[] = [];
    if (input.search) {
      // LOCATE mencari substring literal: % dan _ tidak menjadi wildcard.
      where.push('(LOCATE(?, name) > 0 OR LOCATE(?, sku) > 0)');
      values.push(input.search, input.search);
    }
    if (input.categoryId !== undefined) {
      where.push('category_id = ?');
      values.push(input.categoryId);
    }
    const condition = where.length ? `WHERE ${where.join(' AND ')}` : '';
    const [counts] = await this.pool.execute<RowDataPacket[]>(
      `SELECT COUNT(*) AS total FROM products ${condition}`,
      values,
    );
    // query() tetap melakukan escaping parameter; LIMIT/OFFSET adalah integer tervalidasi.
    const [rows] = await this.pool.query<RowDataPacket[]>(
      `SELECT ${columns} FROM products ${condition} ORDER BY id DESC LIMIT ? OFFSET ?`,
      [...values, input.limit, (input.page - 1) * input.limit],
    );
    const total = Number(counts[0]?.total ?? 0);
    return {
      data: rows.map(product),
      meta: {
        page: input.page,
        limit: input.limit,
        total,
        totalPages: Math.ceil(total / input.limit),
      },
    };
  }
  async find(id: number) {
    const [rows] = await this.pool.execute<RowDataPacket[]>(
      `SELECT ${columns} FROM products WHERE id = ?`,
      [id],
    );
    return rows[0] ? product(rows[0]) : undefined;
  }
  async create(input: ProductInput) {
    const [result] = await this.pool.execute<ResultSetHeader>(
      'INSERT INTO products (name, sku, category_id, price, stock) VALUES (?, ?, ?, ?, ?)',
      [input.name, input.sku, input.categoryId, input.price, input.stock],
    );
    const created = await this.find(result.insertId);
    if (!created) throw new Error('Produk baru tidak ditemukan.');
    return created;
  }
  async update(id: number, input: ProductInput) {
    const [result] = await this.pool.execute<ResultSetHeader>(
      'UPDATE products SET name = ?, sku = ?, category_id = ?, price = ?, stock = ? WHERE id = ?',
      [input.name, input.sku, input.categoryId, input.price, input.stock, id],
    );
    return result.affectedRows ? this.find(id) : undefined;
  }
  async delete(id: number) {
    const [result] = await this.pool.execute<ResultSetHeader>(
      'DELETE FROM products WHERE id = ?',
      [id],
    );
    return result.affectedRows > 0;
  }
  async categories() {
    const [rows] = await this.pool.execute<RowDataPacket[]>(
      'SELECT id, name FROM categories ORDER BY name',
    );
    return rows.map((row) => ({ id: Number(row.id), name: String(row.name) }));
  }
}
