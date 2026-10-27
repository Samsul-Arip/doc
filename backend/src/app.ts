import express from 'express';
import cors from 'cors';
import helmet from 'helmet';
import { pinoHttp } from 'pino-http';
import { pino } from 'pino';
import { InventoryController } from './controller.js';
import { InventoryService } from './service.js';
import type { InventoryRepository } from './repository.js';
import { errorHandler, HttpError } from './errors.js';
export function createApp(
  repo: InventoryRepository,
  checkDb: () => Promise<void>,
  origins: string[] = [],
  silent = false,
) {
  const app = express();
  app.disable('x-powered-by');
  app.use(
    pinoHttp({
      logger: pino({
        level: silent ? 'silent' : 'info',
        redact: ['req.headers.authorization', 'req.headers.cookie'],
      }),
    }),
  );
  app.use(helmet());
  app.use(cors({ origin: origins, credentials: false }));
  app.use(express.json({ limit: '32kb' }));
  app.get('/health', (_req, res) => {
    res.json({ status: 'ok' });
  });
  app.get('/ready', async (_req, res) => {
    try {
      await checkDb();
      res.json({ status: 'ready' });
    } catch {
      res.status(503).json({ error: { message: 'Database belum siap.' } });
    }
  });
  const controller = new InventoryController(new InventoryService(repo));
  const router = express.Router();
  router.get('/products', controller.list);
  router.get('/products/:id', controller.get);
  router.post('/products', controller.create);
  router.put('/products/:id', controller.update);
  router.delete('/products/:id', controller.delete);
  router.get('/categories', controller.categories);
  app.use('/api', router);
  app.use((_req, _res, next) =>
    next(new HttpError(404, 'Endpoint tidak ditemukan.')),
  );
  // Syntax JSON dan body terlalu besar juga harus menghasilkan pesan aman.
  app.use(((error, _req, _res, next) => {
    if (error.type === 'entity.parse.failed')
      return next(new HttpError(400, 'JSON tidak valid.'));
    if (error.type === 'entity.too.large')
      return next(new HttpError(413, 'Body terlalu besar.'));
    next(error);
  }) as express.ErrorRequestHandler);
  app.use(errorHandler);
  return app;
}
