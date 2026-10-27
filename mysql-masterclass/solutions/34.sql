-- Hitung persentase nilai stok masing-masing kategori terhadap seluruh nilai stok.
-- Window total tidak mengurangi jumlah baris; NULLIF mencegah pembagian nol.
WITH value_per_category AS (SELECT category_id, SUM(price * stock) AS stock_value FROM products GROUP BY category_id) SELECT category_id, stock_value, ROUND(100.0 * stock_value / NULLIF(SUM(stock_value) OVER (),0),2) AS percentage FROM value_per_category ORDER BY category_id;
