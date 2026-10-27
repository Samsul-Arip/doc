import { z } from 'zod';
export const idSchema = z.coerce.number().int().positive().max(2147483647);
export const productSchema = z
  .object({
    name: z.string().trim().min(1).max(120),
    sku: z
      .string()
      .trim()
      .min(1)
      .max(40)
      .regex(/^[A-Za-z0-9_-]+$/, 'SKU hanya huruf, angka, _ dan -.'),
    categoryId: z.number().int().positive().max(2147483647),
    price: z
      .number()
      .finite()
      .min(0)
      .max(9999999999.99)
      .refine(
        (v) => Math.abs(v * 100 - Math.round(v * 100)) < 0.0001,
        'Maksimal dua desimal.',
      ),
    stock: z.number().int().min(0).max(2147483647),
  })
  .strict();
export const listSchema = z
  .object({
    page: z.coerce.number().int().min(1).max(100000).default(1),
    limit: z.coerce.number().int().min(1).max(100).default(20),
    search: z.string().trim().max(120).default(''),
    categoryId: idSchema.optional(),
  })
  .strict();
export type ProductInput = z.infer<typeof productSchema>;
export type ListInput = z.infer<typeof listSchema>;
export interface Product extends ProductInput {
  id: number;
  createdAt: string;
  updatedAt: string;
}
export interface Category {
  id: number;
  name: string;
}
export interface ProductPage {
  data: Product[];
  meta: { page: number; limit: number; total: number; totalPages: number };
}
