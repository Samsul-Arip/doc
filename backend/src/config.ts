import 'dotenv/config';
import { z } from 'zod';
export const config = z
  .object({
    NODE_ENV: z
      .enum(['development', 'test', 'production'])
      .default('development'),
    PORT: z.coerce.number().int().min(1).max(65535).default(3000),
    DB_HOST: z.string().min(1).default('127.0.0.1'),
    DB_PORT: z.coerce.number().int().min(1).max(65535).default(3306),
    DB_USER: z.string().min(1),
    DB_PASSWORD: z.string().min(1),
    DB_NAME: z.string().regex(/^[A-Za-z0-9_]+$/),
    CORS_ORIGINS: z.string().default(''),
  })
  .parse(process.env);
