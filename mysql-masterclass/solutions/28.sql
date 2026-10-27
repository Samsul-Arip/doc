-- Bandingkan RANK dan DENSE_RANK pada gaji seri.
-- Jangan memasukkan id dalam OVER: akan memecah nilai seri. RANK melompat, DENSE_RANK tidak.
SELECT name, salary, RANK() OVER (ORDER BY salary DESC) AS rank_salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_salary FROM employees ORDER BY salary DESC, id;
