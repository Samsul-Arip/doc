# Membaca algoritma dengan invariant

Kontrak, contoh, edge case, dan kompleksitas tiap algoritma ada di [soal](../exercises/30-soal.md) dan [pembahasan](../solutions/README.md). `Algorithms.kt` berisi implementasi nyata; jalankan `bash scripts/kotlin.sh algorithms` dari root untuk demo dan `bash scripts/kotlin.sh test` untuk semua tes.

- **FizzBuzz:** cabang 15 lebih dahulu agar kelipatan bersama tidak berhenti di Fizz saja. Penyimpanan list membuat ruang O(n); versi print langsung bisa O(1) tambahan di luar output.
- **Fibonacci:** sebelum iterasi, previous dan current berisi dua suku berurutan. Berhenti di F(92) karena menghitung F(93) melampaui Long. Versi rekursif naif menghitung submasalah berulang; loop menghindarinya.
- **Factorial:** setelah mengalikan i, result=i!. Nilai awal 1 memenuhi 0! dan 1!. Long hanya aman sampai 20!; gunakan BigInteger bila kontrak lebih besar.
- **Prima:** bila n=a*b, salah satu faktor pasti ≤sqrt(n). Membagi sampai n-1 tidak perlu. n/d menghindari d*d overflow.
- **Palindrome/reverse:** dua pointer mengecilkan rentang yang belum diperiksa. Reverse String memakai StringBuilder, bukan penggabungan string immutable berulang yang bisa O(n²).
- **Min/max:** setelah memproses prefix, kandidat adalah min/max prefix itu. Jangan mulai min dari nol jika seluruh input positif.
- **Bubble sort:** setiap pass menempatkan maksimum rentang aktif di ujung kanan. `swapped=false` menandai seluruh rentang sudah terurut; algoritma stabil karena hanya menukar `>`.
- **Deduplikasi/frekuensi:** hash set/map rata-rata O(1) per operasi; O(n) keseluruhan adalah ekspektasi, bukan jaminan universal terhadap semua strategi hashing.
- **Two Sum:** map hanya menyimpan indeks yang telah dilewati sehingga satu elemen tidak dipakai dua kali. Selisih dihitung Long agar target-value tidak overflow Int.
- **Binary search:** rentang low..high mengandung kandidat yang belum dieliminasi. Setiap iterasi membuang sekitar setengah rentang. Saat cocok, bergerak kiri untuk mencari kemunculan pertama. Menguji input terurut di dalam fungsi akan mengubah waktu jadi O(n), maka ini prasyarat yang harus dijelaskan pada pewawancara.

**Unicode:** Kotlin String memakai UTF-16. Char dapat berupa setengah surrogate pair, dan satu karakter visual dapat terdiri dari beberapa code point. Latihan reverse/palindrome/frekuensi membatasi ASCII dengan sengaja. Untuk teks pengguna sungguhan, sepakati normalisasi serta segmentasi grapheme; jangan mengklaim loop Char menangani semua emoji.
