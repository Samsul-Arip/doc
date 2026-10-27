-- Hitung statistik gaji tiap departemen berpegawai: jumlah, rata-rata, minimum dan maksimum.
-- Agregat merangkum kelompok; semua kolom non-agregat ada pada GROUP BY agar ONLY_FULL_GROUP_BY lulus.
SELECT department_id, COUNT(*) AS employee_count, ROUND(AVG(salary),2) AS average_salary, MIN(salary) AS minimum_salary, MAX(salary) AS maximum_salary FROM employees GROUP BY department_id ORDER BY department_id;
