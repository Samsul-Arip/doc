-- Hitung omzet kumulatif paid menurut waktu pesanan.
-- Frame ROWS menjelaskan bahwa setiap baris menambah satu total pesanan.
WITH totals AS (SELECT o.id, o.ordered_at, SUM(i.quantity * i.unit_price) AS total FROM orders o JOIN order_items i ON i.order_id = o.id WHERE o.status = 'paid' GROUP BY o.id, o.ordered_at) SELECT id, total, SUM(total) OVER (ORDER BY ordered_at, id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total FROM totals ORDER BY ordered_at, id;
