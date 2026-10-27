-- Cari pegawai yang gajinya melebihi rata-rata departemen masing-masing.
-- Subquery terkorelasi memakai department_id dari baris luar.
SELECT e.name, e.salary FROM employees e WHERE e.salary > (SELECT AVG(x.salary) FROM employees x WHERE x.department_id = e.department_id) ORDER BY e.id;
