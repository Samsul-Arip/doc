-- Cari kategori dengan minimal tiga produk.
-- HAVING menyaring kelompok setelah agregasi, berbeda dengan WHERE.
SELECT category_id, COUNT(*) AS product_count FROM products GROUP BY category_id HAVING COUNT(*) >= 3 ORDER BY category_id;
