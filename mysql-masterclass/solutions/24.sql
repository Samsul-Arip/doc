-- Hitung omzet hanya pesanan paid.
-- Filter status sebelum menjumlahkan agar pending/cancelled tidak menambah omzet.
SELECT SUM(i.quantity * i.unit_price) AS revenue FROM orders o JOIN order_items i ON i.order_id = o.id WHERE o.status = 'paid';
