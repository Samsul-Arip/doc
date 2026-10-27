# Dasar Kotlin: pikirkan nilai sebelum sintaks

Jalankan `bash scripts/kotlin.sh basics` dari root. Source `Basics.kt` menampilkan contoh yang bisa dikompilasi. Kotlin memeriksa tipe sebelum runtime. Angka `1` adalah Int, `1L` Long, `1.0` Double; tipe tidak otomatis dapat dicampur pada parameter fungsi.

| Topik | Contoh | Mengapa / jebakan |
|---|---|---|
| val dan var | `val n = 4`, `var i = 1` | val tidak dapat ditugaskan ulang; isi mutable list masih bisa berubah. Pilih val bila memungkinkan. |
| Int, Long | `val total = 1L` | Int 32 bit, Long 64 bit; keduanya bisa overflow tanpa exception. Pakai batas input atau pemeriksaan eksplisit. |
| String, Char | `"Ayu"`, `'A'` | String teks, Char satu unit UTF-16, bukan selalu satu karakter visual. |
| Boolean | `stock > 0` | Hanya true/false, bukan angka 0/1. |
| Nullable | `val name: String? = null` | Gunakan `name?.length ?: 0`, hindari `!!` tanpa alasan kuat. |
| Aritmatika | `+ - * / %` | `5 / 2` menghasilkan 2; `5 / 2.0` menghasilkan 2.5; `%` adalah sisa, dapat negatif. |
| Perbandingan | `== != < <= > >=` | `==` membandingkan nilai; `===` membandingkan identitas referensi. |
| AND | `a && b` | b dievaluasi hanya bila a true. Keduanya harus true agar hasil true. |
| OR | `a || b` | b dievaluasi hanya bila a false. Satu true sudah cukup. |
| NOT | `!available` | Membalik Boolean. `!` lebih kuat dari `&&`, dan `&&` lebih kuat dari `||`. |
| if/else | `val label = if (x > 0) "positif" else "lain"` | if adalah expression; bila dipakai sebagai nilai harus ada else. |
| when | `when(x) { 0 -> "nol"; else -> "lain" }` | Memilih cabang cocok pertama; dapat memakai rentang `in 1..4`. |
| for | `for (i in 1..n)` | `..` inklusif, `until` eksklusif ujung akhir. `1..0` kosong. |
| while | `while (i < n) { i++ }` | Kondisi dicek dahulu; tubuh bisa tidak jalan sama sekali. |
| do while | `do { i++ } while(i < n)` | Tubuh pasti jalan minimal satu kali. |
| Nested loop | `for(i in 1..n) for(j in 1..n)` | Loop luar memilih baris, loop dalam menuntaskan semua kolom. Total n×n sel. |
| Array/List | `intArrayOf(1,2)`, `listOf(1,2)` | Array ukurannya tetap; List read-only lewat referensi ini, mutableListOf bisa ditambah. Indeks mulai nol. |
| String | `text.trim().lowercase()` | trim/lowercase menghasilkan string baru. Kontrak soal harus menyatakan apakah kapital/spasi dianggap sama. |

## Tabel kebenaran

| a | b | a && b | a \|\| b |
|---|---|---|---|
| false | false | false | false |
| false | true | false | true |
| true | false | false | true |
| true | true | true | true |

Evaluasi `i <= n && j >= batas`: jika `i <= n` false, operand kanan **tidak dieksekusi**, bukan dihitung false. Perbedaan ini penting bila operand memanggil fungsi atau mengakses indeks array. `index < list.size && list[index] == 5` aman untuk indeks nonnegatif; sebaliknya dapat menyebabkan exception.

## Cara memecahkan soal

1. Nyatakan input, output, ukuran maksimal, dan perilaku input kosong.
2. Kerjakan contoh kecil manual (n=1,2,3), lalu beri nama variabel yang berubah.
3. Tuliskan invariant: misalnya setelah memproses i elemen, min adalah minimum prefix tersebut.
4. Pilih algoritma paling sederhana yang sesuai batas waktu/ruang.
5. Cek tepi rentang, duplikasi, negatif, dan overflow. Jelaskan kompleksitas, bukan sekadar menyebut Big-O.

Latihan pemanasan: stok awal 3, ditambah 2, lalu dijual 5. Cetak label Habis jika stok 0. Input stok dan perubahan berada -100..100; keluaran `Habis`. Solusi: stok menjadi 0 lalu `if (stock == 0)`. Waktu dan ruang O(1). Cek stok negatif sebagai input bisnis yang harus ditolak, bukan otomatis dianggap tersedia.

Lanjutkan [sepuluh praktik dasar dengan kontrak, contoh, pembahasan, dan kompleksitas](10-praktik.md).
