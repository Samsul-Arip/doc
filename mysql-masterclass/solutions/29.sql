-- Tampilkan pegawai bergaji tertinggi di setiap departemen termasuk seri.
-- PARTITION BY memulai ulang ranking pada tiap departemen. Filter window dilakukan di luar CTE.
WITH ranked AS (SELECT id, name, department_id, salary, DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rnk FROM employees) SELECT name, department_id, salary FROM ranked WHERE rnk = 1 ORDER BY department_id, id;
