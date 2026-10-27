-- Tampilkan harga kedua tertinggi yang berbeda.
-- MAX di bawah maksimum mengabaikan seri; bila hanya satu harga berbeda hasilnya NULL.
SELECT MAX(price) AS second_price FROM products WHERE price < (SELECT MAX(price) FROM products);
