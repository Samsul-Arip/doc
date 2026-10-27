import type { InventoryRepository } from './repository.js';
import type { ListInput, ProductInput } from './validation.js';
import { HttpError } from './errors.js';
export class InventoryService {
  constructor(private repo: InventoryRepository) {}
  list(input: ListInput) {
    return this.repo.list(input);
  }
  categories() {
    return this.repo.categories();
  }
  async get(id: number) {
    const data = await this.repo.find(id);
    if (!data) throw new HttpError(404, 'Produk tidak ditemukan.');
    return data;
  }
  create(input: ProductInput) {
    return this.repo.create(input);
  }
  async update(id: number, input: ProductInput) {
    const data = await this.repo.update(id, input);
    if (!data) throw new HttpError(404, 'Produk tidak ditemukan.');
    return data;
  }
  async delete(id: number) {
    if (!(await this.repo.delete(id)))
      throw new HttpError(404, 'Produk tidak ditemukan.');
  }
}
