-- Gabungkan kota Jakarta/Bandung dengan Jakarta/Bogor tanpa duplikasi (UNION).
-- UNION menyatukan lalu deduplikasi seluruh baris hasil.
SELECT city FROM customers WHERE city IN ('Jakarta','Bandung') UNION SELECT city FROM customers WHERE city IN ('Jakarta','Bogor') ORDER BY city;
