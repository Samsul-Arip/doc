# 35 latihan SQL

Gunakan seed asli; reset sebelum mulai. Semua query harus memberi urutan seperti expected result. Hasil harga/gaji dalam rupiah. Jangan membuka folder `solutions` sebelum mencoba.

Latihan 01–10 fundamental, 11–25 relasi/agregasi, 26–35 analisis. `Intermediate` pada beberapa nomor akhir sengaja menjadi jeda penguatan.

## 01. Beginner

Tampilkan id, nama, dan harga seluruh produk berdasarkan id.

Expected result:

| id | name | price |
| --- | --- | --- |
| 1 | Laptop | 12000000 |
| 2 | Monitor | 2500000 |
| 3 | Keyboard | 350000 |
| 4 | Mouse | 150000 |
| 5 | Buku | 25000 |
| 6 | Pulpen | 5000 |
| 7 | Headset | 500000 |
| 8 | Webcam | 700000 |


## 02. Beginner

Cari produk dengan stok nol.

Expected result:

| id | name |
| --- | --- |
| 4 | Mouse |


## 03. Beginner

Tampilkan tiga produk termahal.

Expected result:

| name | price |
| --- | --- |
| Laptop | 12000000 |
| Monitor | 2500000 |
| Webcam | 700000 |


## 04. Beginner

Tampilkan kota pelanggan yang unik secara alfabetis.

Expected result:

| city |
| --- |
| Bandung |
| Bogor |
| Jakarta |
| Surabaya |


## 05. Beginner

Cari produk dengan nama mengandung huruf o.

Expected result:

| id | name |
| --- | --- |
| 1 | Laptop |
| 2 | Monitor |
| 3 | Keyboard |
| 4 | Mouse |


## 06. Beginner

Cari produk kategori 1 atau 3.

Expected result:

| id | name |
| --- | --- |
| 1 | Laptop |
| 2 | Monitor |
| 5 | Buku |
| 6 | Pulpen |
| 8 | Webcam |


## 07. Beginner

Cari produk seharga 25000 sampai 500000 inklusif.

Expected result:

| name | price |
| --- | --- |
| Keyboard | 350000 |
| Mouse | 150000 |
| Buku | 25000 |
| Headset | 500000 |


## 08. Beginner

Tampilkan pelanggan yang belum memiliki nomor telepon.

Expected result:

| id | name |
| --- | --- |
| 2 | Bella |
| 5 | Eko |


## 09. Beginner

Hitung jumlah produk dan total stok.

Expected result:

| product_count | total_stock |
| --- | --- |
| 8 | 193 |


## 10. Beginner

Tampilkan produk dengan stok positif dan harga di bawah 500000.

Expected result:

| id | name |
| --- | --- |
| 3 | Keyboard |
| 5 | Buku |
| 6 | Pulpen |


## 11. Intermediate

Pasangkan setiap produk dengan nama kategorinya (INNER JOIN).

Expected result:

| id | name | category |
| --- | --- | --- |
| 1 | Laptop | Elektronik |
| 2 | Monitor | Elektronik |
| 3 | Keyboard | Aksesori |
| 4 | Mouse | Aksesori |
| 5 | Buku | ATK |
| 6 | Pulpen | ATK |
| 7 | Headset | Aksesori |
| 8 | Webcam | Elektronik |


## 12. Intermediate

Hitung produk tiap kategori, termasuk kategori kosong (LEFT JOIN).

Expected result:

| id | name | product_count |
| --- | --- | --- |
| 1 | Elektronik | 3 |
| 2 | Aksesori | 3 |
| 3 | ATK | 2 |
| 4 | Furniture | 0 |


## 13. Intermediate

Tampilkan semua departemen dengan pegawainya termasuk departemen kosong (RIGHT JOIN).

Expected result:

| department | employee |
| --- | --- |
| Engineering | Ayu |
| Engineering | Bima |
| Engineering | Fajar |
| Sales | Citra |
| Sales | Dedi |
| HR | Eka |
| Support | NULL |


## 14. Intermediate

Tampilkan nama setiap pegawai beserta nama manajernya (SELF JOIN).

Expected result:

| employee | manager |
| --- | --- |
| Ayu | NULL |
| Bima | Ayu |
| Citra | NULL |
| Dedi | Citra |
| Eka | NULL |
| Fajar | Ayu |


## 15. Intermediate

Gabungkan kota Jakarta/Bandung dengan Jakarta/Bogor tanpa duplikasi (UNION).

Expected result:

| city |
| --- |
| Bandung |
| Bogor |
| Jakarta |


## 16. Intermediate

Ulangi gabungan kota dengan semua duplikasi (UNION ALL).

Expected result:

| city |
| --- |
| Bandung |
| Bogor |
| Jakarta |
| Jakarta |
| Jakarta |
| Jakarta |


## 17. Intermediate

Hitung statistik gaji tiap departemen berpegawai: jumlah, rata-rata, minimum dan maksimum.

Expected result:

| department_id | employee_count | average_salary | minimum_salary | maximum_salary |
| --- | --- | --- | --- | --- |
| 1 | 3 | 10666666.67 | 10000000 | 12000000 |
| 2 | 2 | 9000000.0 | 9000000 | 9000000 |
| 3 | 1 | 8000000.0 | 8000000 | 8000000 |


## 18. Intermediate

Cari kategori dengan minimal tiga produk.

Expected result:

| category_id | product_count |
| --- | --- |
| 1 | 3 |
| 2 | 3 |


## 19. Intermediate

Cari pegawai bergaji di atas rata-rata perusahaan.

Expected result:

| name | salary |
| --- | --- |
| Ayu | 12000000 |
| Bima | 10000000 |
| Fajar | 10000000 |


## 20. Intermediate

Beri label Habis, Rendah (1..7), atau Cukup pada stok produk.

Expected result:

| id | name | stock_label |
| --- | --- | --- |
| 1 | Laptop | Rendah |
| 2 | Monitor | Cukup |
| 3 | Keyboard | Cukup |
| 4 | Mouse | Habis |
| 5 | Buku | Cukup |
| 6 | Pulpen | Cukup |
| 7 | Headset | Rendah |
| 8 | Webcam | Rendah |


## 21. Intermediate

Cari pelanggan dengan setidaknya satu pesanan paid (EXISTS).

Expected result:

| id | name |
| --- | --- |
| 1 | Andi |
| 2 | Bella |
| 4 | Dina |


## 22. Intermediate

Cari pelanggan tanpa pesanan sama sekali.

Expected result:

| id | name |
| --- | --- |
| 5 | Eko |


## 23. Intermediate

Hitung total uang masing-masing pesanan tanpa memandang status.

Expected result:

| order_id | total |
| --- | --- |
| 1 | 12700000 |
| 2 | 2650000 |
| 3 | 100000 |
| 4 | 50000 |
| 5 | 850000 |
| 6 | 350000 |


## 24. Intermediate

Hitung omzet hanya pesanan paid.

Expected result:

| revenue |
| --- |
| 16550000 |


## 25. Intermediate

Cari produk yang belum pernah dipesan pada status apa pun.

Expected result:

| id | name |
| --- | --- |
| 8 | Webcam |


## 26. Advanced

Gunakan CTE untuk mencari pesanan bernilai di atas satu juta.

Expected result:

| order_id | total |
| --- | --- |
| 1 | 12700000 |
| 2 | 2650000 |


## 27. Advanced

Nomori pegawai berdasarkan gaji tertinggi lalu id (ROW_NUMBER).

Expected result:

| name | salary | position |
| --- | --- | --- |
| Ayu | 12000000 | 1 |
| Bima | 10000000 | 2 |
| Fajar | 10000000 | 3 |
| Citra | 9000000 | 4 |
| Dedi | 9000000 | 5 |
| Eka | 8000000 | 6 |


## 28. Advanced

Bandingkan RANK dan DENSE_RANK pada gaji seri.

Expected result:

| name | salary | rank_salary | dense_salary |
| --- | --- | --- | --- |
| Ayu | 12000000 | 1 | 1 |
| Bima | 10000000 | 2 | 2 |
| Fajar | 10000000 | 2 | 2 |
| Citra | 9000000 | 4 | 3 |
| Dedi | 9000000 | 4 | 3 |
| Eka | 8000000 | 6 | 4 |


## 29. Advanced

Tampilkan pegawai bergaji tertinggi di setiap departemen termasuk seri.

Expected result:

| name | department_id | salary |
| --- | --- | --- |
| Ayu | 1 | 12000000 |
| Citra | 2 | 9000000 |
| Dedi | 2 | 9000000 |
| Eka | 3 | 8000000 |


## 30. Advanced

Hitung omzet kumulatif paid menurut waktu pesanan.

Expected result:

| id | total | running_total |
| --- | --- | --- |
| 1 | 12700000 | 12700000 |
| 2 | 2650000 | 15350000 |
| 5 | 850000 | 16200000 |
| 6 | 350000 | 16550000 |


## 31. Advanced

Tampilkan harga kedua tertinggi yang berbeda.

Expected result:

| second_price |
| --- |
| 2500000 |


## 32. Intermediate

Hitung omzet paid per pelanggan, termasuk yang nol.

Expected result:

| id | name | revenue |
| --- | --- | --- |
| 1 | Andi | 12700000 |
| 2 | Bella | 3000000 |
| 3 | Chandra | 0 |
| 4 | Dina | 850000 |
| 5 | Eko | 0 |


## 33. Intermediate

Tampilkan pesanan Januari 2026 memakai rentang ramah indeks.

Expected result:

| id | status |
| --- | --- |
| 1 | paid |
| 2 | paid |
| 3 | pending |
| 4 | cancelled |
| 5 | paid |


## 34. Advanced

Hitung persentase nilai stok masing-masing kategori terhadap seluruh nilai stok.

Expected result:

| category_id | stock_value | percentage |
| --- | --- | --- |
| 1 | 82100000 | 87.02 |
| 2 | 10500000 | 11.13 |
| 3 | 1750000 | 1.85 |


## 35. Advanced

Cari pegawai yang gajinya melebihi rata-rata departemen masing-masing.

Expected result:

| name | salary |
| --- | --- |
| Ayu | 12000000 |
