-- Cari produk kategori 1 atau 3.
-- IN ekuivalen OR pada daftar nilai yang sama.
SELECT id, name FROM products WHERE category_id IN (1,3) ORDER BY id;
