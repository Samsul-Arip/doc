-- Gunakan CTE untuk mencari pesanan bernilai di atas satu juta.
-- CTE memberi nama pada hasil antara agar query bisa dibaca tahap demi tahap.
WITH totals AS (SELECT order_id, SUM(quantity * unit_price) AS total FROM order_items GROUP BY order_id) SELECT order_id, total FROM totals WHERE total > 1000000 ORDER BY order_id;
