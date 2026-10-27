-- Tampilkan nama setiap pegawai beserta nama manajernya (SELF JOIN).
-- Alias berbeda mewakili peran pegawai dan manajer pada tabel yang sama.
SELECT e.name AS employee, m.name AS manager FROM employees e LEFT JOIN employees m ON m.id = e.manager_id ORDER BY e.id;
