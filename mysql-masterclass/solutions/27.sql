-- Nomori pegawai berdasarkan gaji tertinggi lalu id (ROW_NUMBER).
-- ROW_NUMBER selalu unik; id memberi urutan deterministik saat gaji sama.
SELECT name, salary, ROW_NUMBER() OVER (ORDER BY salary DESC, id) AS position FROM employees ORDER BY salary DESC, id;
