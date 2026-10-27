-- Cari produk dengan nama mengandung huruf o.
-- Persen mewakili nol atau lebih karakter; collation MySQL menentukan sensitivitas huruf.
SELECT id, name FROM products WHERE name LIKE '%o%' ORDER BY id;
