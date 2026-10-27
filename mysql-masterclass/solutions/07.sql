-- Cari produk seharga 25000 sampai 500000 inklusif.
-- BETWEEN memasukkan kedua batas.
SELECT name, price FROM products WHERE price BETWEEN 25000 AND 500000 ORDER BY id;
