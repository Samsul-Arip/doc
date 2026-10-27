-- Tampilkan semua departemen dengan pegawainya termasuk departemen kosong (RIGHT JOIN).
-- RIGHT JOIN mempertahankan sisi kanan; LEFT JOIN dengan tabel ditukar lebih sering digunakan.
SELECT d.name AS department, e.name AS employee FROM employees e RIGHT JOIN departments d ON d.id = e.department_id ORDER BY d.id, e.id;
