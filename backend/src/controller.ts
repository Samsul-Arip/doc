import type { Request, Response } from 'express';
import { InventoryService } from './service.js';
import { idSchema, listSchema, productSchema } from './validation.js';
export class InventoryController {
  constructor(private service: InventoryService) {}
  list = async (req: Request, res: Response) => {
    res.json(await this.service.list(listSchema.parse(req.query)));
  };
  get = async (req: Request, res: Response) => {
    res.json({ data: await this.service.get(idSchema.parse(req.params.id)) });
  };
  create = async (req: Request, res: Response) => {
    const data = await this.service.create(productSchema.parse(req.body));
    res.location(`/api/products/${data.id}`).status(201).json({ data });
  };
  update = async (req: Request, res: Response) => {
    res.json({
      data: await this.service.update(
        idSchema.parse(req.params.id),
        productSchema.parse(req.body),
      ),
    });
  };
  delete = async (req: Request, res: Response) => {
    await this.service.delete(idSchema.parse(req.params.id));
    res.status(204).end();
  };
  categories = async (_req: Request, res: Response) => {
    res.json({ data: await this.service.categories() });
  };
}
