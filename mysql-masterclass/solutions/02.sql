-- Cari produk dengan stok nol.
-- WHERE menyaring setiap baris sebelum proyeksi.
SELECT id, name FROM products WHERE stock = 0 ORDER BY id;
