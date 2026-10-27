-- Hitung omzet paid per pelanggan, termasuk yang nol.
-- Filter status berada di ON agar pelanggan tanpa paid tetap dipertahankan.
SELECT c.id, c.name, COALESCE(SUM(i.quantity * i.unit_price),0) AS revenue FROM customers c LEFT JOIN orders o ON o.customer_id = c.id AND o.status = 'paid' LEFT JOIN order_items i ON i.order_id = o.id GROUP BY c.id, c.name ORDER BY c.id;
