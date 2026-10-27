import mysql from 'mysql2/promise';
import { pino } from 'pino';
import { config } from './config.js';
import { MysqlInventoryRepository } from './repository.js';
import { createApp } from './app.js';
const logger = pino();
const pool = mysql.createPool({
  host: config.DB_HOST,
  port: config.DB_PORT,
  user: config.DB_USER,
  password: config.DB_PASSWORD,
  database: config.DB_NAME,
  connectionLimit: 10,
  waitForConnections: true,
  queueLimit: 100,
  timezone: 'Z',
  dateStrings: true,
  connectTimeout: 5000,
});
// DATETIME menyimpan jam tanpa zona; samakan sesi SQL menjadi UTC.
pool.on('connection', (connection) => {
  connection.query("SET time_zone = '+00:00'");
});
const app = createApp(
  new MysqlInventoryRepository(pool),
  async () => {
    await pool.query('SELECT 1');
  },
  config.CORS_ORIGINS.split(',').filter(Boolean),
);
const server = app.listen(config.PORT, '0.0.0.0', () =>
  logger.info({ port: config.PORT }, 'API siap menerima permintaan'),
);
let closing = false;
function shutdown() {
  if (closing) return;
  closing = true;
  logger.info('Menutup HTTP dan koneksi database');
  const deadline = setTimeout(() => {
    logger.error('Batas waktu shutdown terlampaui');
    server.closeAllConnections();
    process.exit(1);
  }, 10000);
  deadline.unref();
  server.close(() => {
    void pool
      .end()
      .then(() => {
        clearTimeout(deadline);
      })
      .catch(() => {
        process.exitCode = 1;
      });
  });
}
process.on('SIGINT', shutdown);
process.on('SIGTERM', shutdown);
