-- Cari pegawai bergaji di atas rata-rata perusahaan.
-- Subquery skalar menghasilkan satu nilai pembanding.
SELECT name, salary FROM employees WHERE salary > (SELECT AVG(salary) FROM employees) ORDER BY id;
