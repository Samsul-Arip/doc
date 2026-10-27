-- Ulangi gabungan kota dengan semua duplikasi (UNION ALL).
-- UNION ALL mempertahankan kemunculan termasuk dua pelanggan Jakarta pada setiap sisi.
SELECT city FROM customers WHERE city IN ('Jakarta','Bandung') UNION ALL SELECT city FROM customers WHERE city IN ('Jakarta','Bogor') ORDER BY city;
