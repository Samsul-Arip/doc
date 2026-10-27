-- Hitung jumlah produk dan total stok.
-- COUNT(*) menghitung baris, SUM menjumlahkan nilai stok.
SELECT COUNT(*) AS product_count, SUM(stock) AS total_stock FROM products;
