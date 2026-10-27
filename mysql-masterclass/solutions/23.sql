-- Hitung total uang masing-masing pesanan tanpa memandang status.
-- Pakai harga historis unit_price, bukan harga katalog saat ini.
SELECT o.id AS order_id, SUM(i.quantity * i.unit_price) AS total FROM orders o JOIN order_items i ON i.order_id = o.id GROUP BY o.id ORDER BY o.id;
