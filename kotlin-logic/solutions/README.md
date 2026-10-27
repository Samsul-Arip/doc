# Pembahasan 30 latihan

Buka setelah mencoba. Fungsi algoritma berada di `algorithms/Algorithms.kt`, pola di `patterns/Patterns.kt`, lima latihan tambahan di `solutions/ExtraSolutions.kt`.

## 01. FizzBuzz

Solusi runnable: `fizzBuzz`. Cek kelipatan 15 sebelum 3/5.

Waktu O(n); ruang tambahan/keluaran O(n). Edge case: n=0 menghasilkan list kosong.

## 02. Fibonacci

Solusi runnable: `fibonacci`. Simpan dua suku sebelumnya dan geser setelah penjumlahan.

Waktu O(n); ruang tambahan/keluaran O(1). Edge case: 0,1,92; 93 ditolak agar Long tidak overflow.

## 03. Factorial

Solusi runnable: `factorial`. Mulai result=1 lalu kali 2..n.

Waktu O(n); ruang tambahan/keluaran O(1). Edge case: 0!=1; negatif/21 ditolak.

## 04. Bilangan prima

Solusi runnable: `isPrime`. Cari pembagi sampai sqrt(n), memakai d<=n/d untuk mencegah overflow.

Waktu O(√n); ruang tambahan/keluaran O(1). Edge case: n<2 false; 2 true; Int.MAX_VALUE.

## 05. Palindrome peka kapital

Solusi runnable: `palindrome`. Bandingkan ujung kiri dan kanan sampai bertemu.

Waktu O(n); ruang tambahan/keluaran O(1). Edge case: String kosong true; Katak false.

## 06. Reverse String

Solusi runnable: `reverseString`. Tambahkan karakter dari indeks terakhir ke StringBuilder.

Waktu O(n); ruang tambahan/keluaran O(n). Edge case: Kosong; satu karakter; spasi dipertahankan.

## 07. Reverse Array tanpa mengubah input

Solusi runnable: `reverseArray`. Salin array lalu tukar dua ujung.

Waktu O(n); ruang tambahan/keluaran O(n). Edge case: Kosong, ganjil/genap; input tetap sama.

## 08. Minimum dan maksimum

Solusi runnable: `minMax`. Inisialisasi dari elemen pertama lalu perbarui minimum/maksimum.

Waktu O(n); ruang tambahan/keluaran O(1). Edge case: Kosong mengembalikan null; semua nilai sama.

## 09. Bubble Sort

Solusi runnable: `bubbleSort`. Tukar pasangan bersebelahan yang terbalik; hentikan bila satu pass tanpa pertukaran.

Waktu O(n²), best O(n); ruang tambahan/keluaran O(n). Edge case: Kosong; sudah terurut; duplikat; negatif.

## 10. Hapus duplikasi, pertahankan urutan pertama

Solusi runnable: `deduplicate`. LinkedHashSet menyimpan urutan insertion sambil menolak nilai sama.

Waktu O(n) rata-rata; ruang tambahan/keluaran O(n). Edge case: Kosong; semua sama; urutan bukan sorting.

## 11. Frekuensi karakter

Solusi runnable: `frequencies`. Map menghubungkan karakter ke jumlah, mulai dari nol.

Waktu O(n) rata-rata; ruang tambahan/keluaran O(k). Edge case: Spasi dihitung; kapital berbeda; k banyak karakter unik.

## 12. Two Sum, indeks berbeda, pasangan pertama yang ditemukan

Solusi runnable: `twoSum`. Cari komplemen di map nilai sebelumnya sebelum menyimpan nilai saat ini.

Waktu O(n) rata-rata; ruang tambahan/keluaran O(n). Edge case: [3,3],6 boleh; satu elemen tak boleh dipakai dua kali; arithmetic Long.

## 13. Binary Search indeks pertama

Solusi runnable: `binarySearch`. Saat ketemu simpan indeks lalu cari lagi ke kiri.

Waktu O(log n); ruang tambahan/keluaran O(1). Edge case: Kosong/tidak ditemukan -1; duplikat; input wajib terurut.

## 14. Segitiga siku-siku

Solusi runnable: `pattern("triangle",n)`. Gunakan batas/rumus pada patterns/README.md; setiap i satu baris, setiap j satu kolom.

Waktu O(n²); ruang tambahan/keluaran O(n²). Edge case: n=1; n=0 ditolak; spasi awal jangan hilang.

## 15. Segitiga terbalik

Solusi runnable: `pattern("inverted-triangle",n)`. Gunakan batas/rumus pada patterns/README.md; setiap i satu baris, setiap j satu kolom.

Waktu O(n²); ruang tambahan/keluaran O(n²). Edge case: n=1; n=0 ditolak; spasi awal jangan hilang.

## 16. Piramida

Solusi runnable: `pattern("pyramid",n)`. Gunakan batas/rumus pada patterns/README.md; setiap i satu baris, setiap j satu kolom.

Waktu O(n²); ruang tambahan/keluaran O(n²). Edge case: n=1; n=0 ditolak; spasi awal jangan hilang.

## 17. Piramida terbalik

Solusi runnable: `pattern("inverted-pyramid",n)`. Gunakan batas/rumus pada patterns/README.md; setiap i satu baris, setiap j satu kolom.

Waktu O(n²); ruang tambahan/keluaran O(n²). Edge case: n=1; n=0 ditolak; spasi awal jangan hilang.

## 18. Diamond satu if

Solusi runnable: `pattern("diamond",n)`. Gunakan batas/rumus pada patterns/README.md; setiap i satu baris, setiap j satu kolom.

Waktu O(n²); ruang tambahan/keluaran O(n²). Edge case: n=1; n=0 ditolak; spasi awal jangan hilang.

## 19. Hollow diamond

Solusi runnable: `pattern("hollow-diamond",n)`. Gunakan batas/rumus pada patterns/README.md; setiap i satu baris, setiap j satu kolom.

Waktu O(n²); ruang tambahan/keluaran O(n²). Edge case: n=1; n=0 ditolak; spasi awal jangan hilang.

## 20. Hollow rectangle

Solusi runnable: `pattern("rectangle",n)`. Gunakan batas/rumus pada patterns/README.md; setiap i satu baris, setiap j satu kolom.

Waktu O(n²); ruang tambahan/keluaran O(n²). Edge case: n=1; n=0 ditolak; spasi awal jangan hilang.

## 21. X pattern

Solusi runnable: `pattern("x",n)`. Gunakan batas/rumus pada patterns/README.md; setiap i satu baris, setiap j satu kolom.

Waktu O(n²); ruang tambahan/keluaran O(n²). Edge case: n=1; n=0 ditolak; spasi awal jangan hilang.

## 22. Butterfly

Solusi runnable: `pattern("butterfly",n)`. Gunakan batas/rumus pada patterns/README.md; setiap i satu baris, setiap j satu kolom.

Waktu O(n²); ruang tambahan/keluaran O(n²). Edge case: n=1; n=0 ditolak; spasi awal jangan hilang.

## 23. Number pyramid

Solusi runnable: `pattern("number-pyramid",n)`. Gunakan batas/rumus pada patterns/README.md; setiap i satu baris, setiap j satu kolom.

Waktu O(n²); ruang tambahan/keluaran O(n²). Edge case: n=1; n=0 ditolak; spasi awal jangan hilang.

## 24. Floyd’s triangle

Solusi runnable: `pattern("floyd",n)`. Gunakan batas/rumus pada patterns/README.md; setiap i satu baris, setiap j satu kolom.

Waktu O(n²); ruang tambahan/keluaran O(n²). Edge case: n=1; n=0 ditolak; spasi awal jangan hilang.

## 25. Pascal’s triangle

Solusi runnable: `pattern("pascal",n)`. Gunakan batas/rumus pada patterns/README.md; setiap i satu baris, setiap j satu kolom.

Waktu O(n²); ruang tambahan/keluaran O(n²). Edge case: n=1; n=0 ditolak; spasi awal jangan hilang.

## 26. Jumlah bilangan genap

Solusi runnable: `sumEven`. Tambahkan hanya nilai dengan v%2==0, akumulator Long.

Waktu O(n); ruang tambahan/keluaran O(1). Edge case: Negatif genap juga dihitung; list kosong nol.

## 27. Hitung vokal

Solusi runnable: `vowelCount`. Ubah tiap karakter ke lowercase lalu cek aiueo.

Waktu O(n); ruang tambahan/keluaran O(1). Edge case: Kapital; spasi; string kosong.

## 28. Nilai terbesar kedua yang berbeda

Solusi runnable: `secondLargest`. Jaga dua kandidat berbeda; geser first ke second saat maksimum baru.

Waktu O(n); ruang tambahan/keluaran O(1). Edge case: Tidak ada dua nilai berbeda mengembalikan null; Int.MIN_VALUE sah.

## 29. Validasi kurung seimbang

Solusi runnable: `balanced`. Depth tak boleh negatif di prefix dan harus nol di akhir.

Waktu O(n); ruang tambahan/keluaran O(1). Edge case: Kosong true; )( false; karakter lain ditolak.

## 30. Gabung dua list terurut

Solusi runnable: `mergeSorted`. Dua pointer memilih nilai terkecil lalu salin sisa.

Waktu O(a+b); ruang tambahan/keluaran O(a+b). Edge case: Salah satu kosong; duplikasi dipertahankan; input harus terurut.
