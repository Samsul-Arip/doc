-- Hindari lost update: ubah stok secara atomik dan periksa ROW_COUNT().
START TRANSACTION;
SELECT stock FROM products WHERE id = 1 FOR UPDATE;
UPDATE products SET stock = stock - 1 WHERE id = 1 AND stock >= 1;
SELECT ROW_COUNT() AS changed_rows; -- 1 berarti berhasil, 0 berarti stok tidak cukup/produk hilang
ROLLBACK; -- ganti COMMIT hanya saat benar-benar ingin menyimpan
-- Indeks komposit mengikuti prefix kiri: kategori dahulu, kemudian id.
EXPLAIN SELECT id, name FROM products WHERE category_id = 1 ORDER BY id DESC LIMIT 20;
-- EXPLAIN ANALYZE benar-benar menjalankan SELECT; pakai untuk analisis di DB latihan.
EXPLAIN ANALYZE SELECT id, name FROM products WHERE category_id = 1 ORDER BY id DESC LIMIT 20;
