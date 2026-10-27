-- Cari pelanggan tanpa pesanan sama sekali.
-- NOT EXISTS aman terhadap NULL; NOT IN dapat menjadi UNKNOWN bila subquery mengandung NULL.
SELECT c.id, c.name FROM customers c WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id) ORDER BY c.id;
