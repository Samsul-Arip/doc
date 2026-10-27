# Checklist dan simulasi technical test

Sebelum mulai, ulangi kontrak soal dengan kata sendiri. Tanyakan batas input bila belum diberikan, tulis contoh kecil, jelaskan asumsi, lalu implementasikan paling sederhana yang memenuhi batas. Sisakan waktu khusus edge case dan menjelaskan hasil.

## Checklist persiapan

- [ ] Kotlin: nested loop, AND/OR short circuit, array/list, nullable, integer overflow.
- [ ] Dapat menurunkan rumus diamond tanpa abs() dan trace i/j di kertas.
- [ ] Dapat menjelaskan O(n), O(n²), O(log n), serta ruang output vs ruang tambahan.
- [ ] SQL: key/FK, NULL, join multiplicity, WHERE/HAVING, UNION/ALL, subquery, CTE/window.
- [ ] Dapat menerangkan ranking seri dan mengapa COUNT(p.id) berbeda dari COUNT(*) pada LEFT JOIN.
- [ ] Backend: request validation, status code, query parameter, pool, env, readiness.
- [ ] Flutter: provider/repository/data source, lifecycle mounted/dispose, validasi, async loading/error/empty.
- [ ] CRUD tersimpan di MySQL, bukan hanya berubah di memori UI.
- [ ] Bisa menjalankan test, membaca failure, dan memperbaiki tanpa menyembunyikannya.
- [ ] Git bersih dari credential dan generated cache; README bisa diikuti orang lain.

## Simulasi ujian 120 menit — kerjakan sebelum membuka rubrik

**Kotlin 30 menit (30 poin).** Implementasikan hollow diamond n=1..20 dengan nested loop dan kondisi gabungan tanpa abs(). n=3 menghasilkan lima baris `  *`, ` * *`, `*   *`, ` * *`, `  *`. Terangkan penurunan empat batas, kompleksitas, dan n=1. Tambahkan binary search indeks pertama untuk input menaik dengan duplikasi.

**SQL 30 menit (30 poin).** Pada seed asli, cari pelanggan tanpa pesanan (Eko), hitung omzet paid (16550000), tampilkan tiga tingkat gaji dengan DENSE_RANK (Ayu:1; Bima/Fajar:2; Citra/Dedi:3), dan semua kategori beserta jumlah produknya (Elektronik:3, Aksesori:3, ATK:2, Furniture:0). Pakai ORDER BY deterministik. Jelaskan mengapa filter paid pada LEFT JOIN diletakkan di ON.

**Flutter/API 50 menit (30 poin).** Buat satu produk dengan SKU unik dari form, validasi harga/stok, ubah, cari/filter, hapus setelah konfirmasi. Tambah satu test yang menangkap bug nyata (misalnya decoding JSON harga string atau request yang gagal), lalu demonstrasikan error state dan retry. Jelaskan mengapa mobile tidak menghubungi MySQL langsung.

**Review 10 menit (10 poin).** Jalankan checks, tampilkan satu edge case yang gagal saat pengerjaan dan perbaikannya, lalu jelaskan satu tradeoff yang sengaja dipilih.

## Rubrik sesudah ujian

Kotlin: 15 benar output, 5 rumus, 5 edge case, 5 binary search. SQL: 5 per query (20), 5 NULL/join, 5 penjelasan agregasi/ranking. Flutter: 12 CRUD persisten, 6 state & validasi, 6 pemisahan tanggung jawab, 6 test. Review: 5 bukti checks, 5 penjelasan jujur. Target kesiapan ≥80/100 dengan tidak ada credential/SQL injection/akses DB langsung dari aplikasi.

Jawaban Kotlin ada di `patterns/Patterns.kt` dan `algorithms/Algorithms.kt`; SQL pada solusi 12,22,24,28. Untuk tiga tingkat gaji, bungkus query ranking di CTE dan filter dense_salary<=3. Jangan memberi LIMIT 3 karena hanya mengambil tiga pegawai, bukan tiga tingkat gaji.

## Pertanyaan wawancara

1. Mengapa `&&` dapat mencegah akses indeks ilegal? Sebut prasyarat indeks nonnegatif.
2. Kapan map Two Sum memakai lebih banyak ruang tetapi menghemat waktu?
3. Mengapa SUM bisa NULL, dan kapan COALESCE masuk akal?
4. Apakah query cepat pada delapan baris membuktikan indeks optimal di jutaan baris?
5. Bagaimana menangani hasil pencarian lama yang selesai setelah pencarian baru?
6. Mengapa timeout, retry, dan mutation tidak boleh dicampur sembarangan? Retry POST dapat membuat duplikasi tanpa idempotency key.
7. Bagaimana autentikasi, otorisasi, audit, TLS, dan rate limit akan ditambahkan sebelum API dipublikasikan?

Saat tidak tahu, nyatakan hal yang belum pasti, pilih eksperimen kecil, dan laporkan buktinya. Hindari mengklaim build/test berhasil jika hanya menulis konfigurasinya.
