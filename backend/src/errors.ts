import type { ErrorRequestHandler } from 'express';
import { ZodError } from 'zod';
export class HttpError extends Error {
  constructor(
    public status: number,
    message: string,
  ) {
    super(message);
  }
}
export const errorHandler: ErrorRequestHandler = (error, req, res, _next) => {
  if (error instanceof ZodError) {
    res.status(400).json({
      error: { message: 'Input tidak valid.', details: error.flatten() },
    });
    return;
  }
  const code = (error as { code?: string }).code;
  if (code === 'ER_DUP_ENTRY') {
    res.status(409).json({ error: { message: 'SKU sudah digunakan.' } });
    return;
  }
  if (code === 'ER_NO_REFERENCED_ROW_2') {
    res.status(400).json({ error: { message: 'Kategori tidak ditemukan.' } });
    return;
  }
  if (code === 'ER_ROW_IS_REFERENCED_2') {
    res
      .status(409)
      .json({ error: { message: 'Produk masih digunakan oleh pesanan.' } });
    return;
  }
  // Jangan kirim SQL, kredensial, atau stack trace ke klien.
  const status = error instanceof HttpError ? error.status : 500;
  if (status >= 500)
    req.log.error({ code: code ?? 'INTERNAL' }, 'Permintaan gagal');
  res.status(status).json({
    error: {
      message: status < 500 ? error.message : 'Terjadi gangguan server.',
    },
  });
};
