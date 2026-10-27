# Sepuluh praktik dasar dengan kontrak lengkap

Implementasi runnable ada di [Essentials.kt](Essentials.kt), diverifikasi oleh TestMain. Batas input adalah bagian kontrak pemanggil; tidak semua fungsi memindai ukuran koleksi kembali karena itu dapat mengubah biaya algoritma.

## 1. Variabel dan tipe data

**Soal/batas input:** Hitung stok setelah penerimaan; awal dan masuk 0..1.000.000.

Input `initial=3, incoming=2` → output `5`.

**Solusi:** fungsi `restock` di Essentials.kt. val result bertipe Int karena jumlah maksimal dua juta, masih muat Int. initial/incoming adalah parameter immutable. Untuk mutasi stok bertahap, var dapat dipakai, tetapi fungsi murni lebih mudah diuji. Jangan memilih String untuk angka karena + dapat menjadi penggabungan teks.

**Kompleksitas:** waktu O(1), ruang O(1). **Edge case:** Nol + nol = nol; negatif ditolak; batas atas dua juta.

## 2. Operator aritmatika

**Soal/batas input:** Bagi barang ke kardus berkapasitas tetap; total 0..1.000.000, kapasitas 1..1.000.000.

Input `total=17, perBox=5` → output `(3,2)`.

**Solusi:** fungsi `quotientRemainder` di Essentials.kt. Pembagian integer memberi jumlah kardus penuh. Modulo memberi barang tersisa. Invariant total = quotient*perBox+remainder. Kapasitas nol ditolak sebelum pembagian.

**Kompleksitas:** waktu O(1), ruang O(1). **Edge case:** Total nol; kapasitas lebih besar dari total; pembagi nol ditolak.

## 3. Operator perbandingan

**Soal/batas input:** Bandingkan dua Int dan hasilkan label.

Input `a=-2, b=3` → output `lebih kecil`.

**Solusi:** fungsi `compareNumbers` di Essentials.kt. Periksa > dahulu, < berikutnya; bila keduanya false nilainya sama. Tidak perlu mengurangkan a-b yang berpotensi overflow.

**Kompleksitas:** waktu O(1), ruang O(1). **Edge case:** Sama, negatif, Int.MIN_VALUE melawan Int.MAX_VALUE.

## 4. AND, OR, NOT

**Soal/batas input:** Barang dapat dibeli jika stok positif, saldo cukup atau VIP, dan barang gratis hanya boleh diambil VIP; semua angka nonnegatif.

Input `stock=1, balance=0, price=100, vip=true` → output `true`.

**Solusi:** fungsi `canBuy` di Essentials.kt. stock>0 menjadi syarat pertama. Grup (balance>=price || vip) menyediakan dua alternatif. !(price==0 && !vip) menolak gratis untuk non-VIP. AND menghentikan keseluruhan bila stok nol. Dengan VIP true, operand kiri OR tetap diperiksa dahulu; OR tidak melompat ke kanan terlebih dahulu.

**Kompleksitas:** waktu O(1), ruang O(1). **Edge case:** Stok nol walau VIP tetap false; gratis non-VIP false; saldo tepat harga true.

## 5. if, else, when

**Soal/batas input:** Kelompokkan nilai 0..100: A≥85, B≥70, C≥55, sisanya D.

Input `score=84` → output `B`.

**Solusi:** fungsi `scoreLabel` di Essentials.kt. Rentang disusun terpisah agar mudah dibaca. when menghasilkan String yang langsung dikembalikan. Alternatif if(score>=85) ... memakai urutan batas menurun agar nilai 90 tidak berhenti di kategori C.

**Kompleksitas:** waktu O(1), ruang O(1). **Edge case:** Batas 54/55/69/70/84/85; nilai di luar 0..100 ditolak.

## 6. for, while, do while

**Soal/batas input:** Jumlahkan 1 sampai n, n=0..10000.

Input `n=4` → output `10`.

**Solusi:** fungsi `sumTo` di Essentials.kt. while memeriksa i<=n sebelum mengerjakan tubuh; n=0 membuat loop kosong. for(i in 1..n) ekuivalen. do while kurang cocok untuk penjumlahan ini tanpa guard karena n=0 tetap melakukan satu iterasi. Contoh do while yang tepat ada pada digitSum.

**Kompleksitas:** waktu O(n), ruang O(1). **Edge case:** n=0 nol; n=10000 muat Long; lupa i++ menyebabkan loop tak berakhir.

## 7. Nested loop

**Soal/batas input:** Buat tabel perkalian n×n, n=1..20.

Input `n=3` → output `[[1,2,3],[2,4,6],[3,6,9]]`.

**Solusi:** fungsi `multiplicationTable` di Essentials.kt. Loop luar membuat satu list baris baru. Loop dalam menambahkan i*j. Jika row dibuat di luar loop luar, baris dapat berbagi referensi list mutable dan hasil menjadi salah. Total ada n² perkalian.

**Kompleksitas:** waktu O(n²), ruang O(n²) keluaran. **Edge case:** n=1 [[1]]; n=0 ditolak; jangan mengulang baris lewat referensi sama.

## 8. Array dan List

**Soal/batas input:** Hitung rata-rata 0..10000 elemen Int; list kosong mengembalikan null.

Input `[1,2]` → output `1.5`.

**Solusi:** fungsi `average` di Essentials.kt. Akumulasi Long menghindari overflow jumlah Int pada batas latihan. Konversi Double dilakukan sebelum pembagian supaya tidak terjadi integer truncation. Fungsi tidak mengubah list. Array bisa dikonversi memakai toList() bila perlu, dengan biaya salinan tambahan.

**Kompleksitas:** waktu O(n), ruang O(1). **Edge case:** Kosong null; semua negatif; satu elemen; rata-rata bukan integer.

## 9. Manipulasi String

**Soal/batas input:** Cek palindrome ASCII tanpa membedakan kapital dan dengan mengabaikan karakter spasi biasa. Panjang 0..10000.

Input `Kasur rusak` → output `true`.

**Solusi:** fungsi `normalizedPalindrome` di Essentials.kt. filter membuang spasi U+0020, lowercase menyamakan kapital, lalu dua pointer memeriksa hasil. Tab/tanda baca sengaja tidak dihapus karena kontraknya hanya spasi. Jika kebutuhan berubah, ubah kontrak dan test bersama.

**Kompleksitas:** waktu O(n), ruang O(n). **Edge case:** Kosong true; semua spasi true; tanda baca tetap dihitung; Unicode grapheme di luar kontrak.

## 10. Problem solving algoritma

**Soal/batas input:** Jumlahkan digit desimal n=0..1.000.000.000.

Input `n=1203` → output `6`.

**Solusi:** fungsi `digitSum` di Essentials.kt. Pecah masalah: sisa bagi 10 adalah digit terakhir; pembagian integer 10 membuang digit itu. Invariant sum+jumlah digit remaining = jumlah digit input. do while memastikan nol tetap diproses sekali tanpa penanganan khusus.

**Kompleksitas:** waktu O(log n) untuk n>0, O(1) pada nol, ruang O(1). **Edge case:** Nol; nol di tengah; satu digit; negatif ditolak, jadi tidak perlu abs() yang berisiko pada Int.MIN_VALUE.
