-- Tampilkan produk dengan stok positif dan harga di bawah 500000.
-- Kedua predikat wajib benar untuk AND.
SELECT id, name FROM products WHERE stock > 0 AND price < 500000 ORDER BY id;
