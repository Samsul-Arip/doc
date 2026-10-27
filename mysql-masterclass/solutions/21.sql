-- Cari pelanggan dengan setidaknya satu pesanan paid (EXISTS).
-- EXISTS hanya memeriksa keberadaan sehingga pelanggan tidak terduplikasi.
SELECT c.id, c.name FROM customers c WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id AND o.status = 'paid') ORDER BY c.id;
