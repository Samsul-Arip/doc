-- Tampilkan tiga produk termahal.
-- Urutkan menurun lalu batasi; id memecahkan harga seri.
SELECT name, price FROM products ORDER BY price DESC, id LIMIT 3;
