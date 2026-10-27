# Membongkar rumus diamond

Source utama persis memakai nested loop dan satu if gabungan di [DiamondMain.kt](DiamondMain.kt), tanpa abs(). Jalankan `kotlinc kotlin-logic/patterns/DiamondMain.kt -include-runtime -d .test-results/diamond.jar` lalu `java -jar .test-results/diamond.jar` (buat `.test-results` dahulu).


## Mengapa size = 2*n - 1?

n adalah tinggi bagian atas termasuk baris terlebar. Ada n-1 baris bawah karena baris tengah tidak diulang. Jumlah baris n+(n-1)=2n-1. Lebar baris terlebar juga 2n-1, dan kolom pusat berada pada j=n.

Untuk i≤n, jarak tepi dari pusat bertambah i-1 setiap turun satu baris. Tepi kiri = n-(i-1)=n-i+1. Tepi kanan = n+(i-1)=n+i-1. Sel diisi bila j di antara kedua tepi, sehingga perlu `j >= kiri && j <= kanan`. Kondisi `i <= n` memastikan rumus ini dipakai di bagian atas.

Untuk i>n, definisikan langkah turun k=i-n. Lebar menyusut dua setiap langkah. Tepi kiri mulai dari 1 pada baris tengah lalu bergerak kanan k langkah: 1+k=i-n+1. Tepi kanan mulai dari size lalu bergerak kiri k langkah: (2n-1)-(i-n)=3n-i-1. Bagian ini dimulai setelah tengah agar tidak dihitung ganda.

Kurung kiri OR benar bila sel masuk bagian atas; kurung kanan OR benar bila sel masuk bagian bawah. Satu sel tidak mungkin berada di kedua bagian sekaligus, tetapi OR menyatukan kedua wilayah. AND berarti seluruh batas dalam wilayah harus terpenuhi.

Untuk n=4: tepi kiri atas berturut 4,3,2,1; tepi kanan 4,5,6,7. Di bawah: kiri 2,3,4; kanan 6,5,4. Jumlah bintang 1,3,5,7,5,3,1; total 25 = n²+(n-1)².

## Trace n=4 untuk semua 49 sel

A=`i<=n`, B=`j>=n-i+1`, C=`j<=n+i-1`, D=`i>n`, E=`j>=i-n+1`, F=`j<=3*n-i-1`. Kolom A..F adalah nilai matematis, termasuk yang tidak dieksekusi. Kolom “Dievaluasi” menandai operand yang **benar-benar dijalankan** dari kiri ke kanan. `T` true, `F` false. Jika AND menemukan false, sisa grup dilewati; jika grup atas true, seluruh grup bawah dilewati. Cetak baru terjadi setelah hasil if diketahui.

| i | j | A | B | C | D | E | F | Dievaluasi | if | Cetak |
|---|---|---|---|---|---|---|---|---|---|---|

| 1 | 1 | T | F | T | F | T | T | A,B,D | F | `spasi` |
| 1 | 2 | T | F | T | F | T | T | A,B,D | F | `spasi` |
| 1 | 3 | T | F | T | F | T | T | A,B,D | F | `spasi` |
| 1 | 4 | T | T | T | F | T | T | A,B,C | T | `*` |
| 1 | 5 | T | T | F | F | T | T | A,B,C,D | F | `spasi` |
| 1 | 6 | T | T | F | F | T | T | A,B,C,D | F | `spasi` |
| 1 | 7 | T | T | F | F | T | T | A,B,C,D | F | `spasi` |
| 2 | 1 | T | F | T | F | T | T | A,B,D | F | `spasi` |
| 2 | 2 | T | F | T | F | T | T | A,B,D | F | `spasi` |
| 2 | 3 | T | T | T | F | T | T | A,B,C | T | `*` |
| 2 | 4 | T | T | T | F | T | T | A,B,C | T | `*` |
| 2 | 5 | T | T | T | F | T | T | A,B,C | T | `*` |
| 2 | 6 | T | T | F | F | T | T | A,B,C,D | F | `spasi` |
| 2 | 7 | T | T | F | F | T | T | A,B,C,D | F | `spasi` |
| 3 | 1 | T | F | T | F | T | T | A,B,D | F | `spasi` |
| 3 | 2 | T | T | T | F | T | T | A,B,C | T | `*` |
| 3 | 3 | T | T | T | F | T | T | A,B,C | T | `*` |
| 3 | 4 | T | T | T | F | T | T | A,B,C | T | `*` |
| 3 | 5 | T | T | T | F | T | T | A,B,C | T | `*` |
| 3 | 6 | T | T | T | F | T | T | A,B,C | T | `*` |
| 3 | 7 | T | T | F | F | T | T | A,B,C,D | F | `spasi` |
| 4 | 1 | T | T | T | F | T | T | A,B,C | T | `*` |
| 4 | 2 | T | T | T | F | T | T | A,B,C | T | `*` |
| 4 | 3 | T | T | T | F | T | T | A,B,C | T | `*` |
| 4 | 4 | T | T | T | F | T | T | A,B,C | T | `*` |
| 4 | 5 | T | T | T | F | T | T | A,B,C | T | `*` |
| 4 | 6 | T | T | T | F | T | T | A,B,C | T | `*` |
| 4 | 7 | T | T | T | F | T | T | A,B,C | T | `*` |
| 5 | 1 | F | T | T | T | F | T | A,D,E | F | `spasi` |
| 5 | 2 | F | T | T | T | T | T | A,D,E,F | T | `*` |
| 5 | 3 | F | T | T | T | T | T | A,D,E,F | T | `*` |
| 5 | 4 | F | T | T | T | T | T | A,D,E,F | T | `*` |
| 5 | 5 | F | T | T | T | T | T | A,D,E,F | T | `*` |
| 5 | 6 | F | T | T | T | T | T | A,D,E,F | T | `*` |
| 5 | 7 | F | T | T | T | T | F | A,D,E,F | F | `spasi` |
| 6 | 1 | F | T | T | T | F | T | A,D,E | F | `spasi` |
| 6 | 2 | F | T | T | T | F | T | A,D,E | F | `spasi` |
| 6 | 3 | F | T | T | T | T | T | A,D,E,F | T | `*` |
| 6 | 4 | F | T | T | T | T | T | A,D,E,F | T | `*` |
| 6 | 5 | F | T | T | T | T | T | A,D,E,F | T | `*` |
| 6 | 6 | F | T | T | T | T | F | A,D,E,F | F | `spasi` |
| 6 | 7 | F | T | T | T | T | F | A,D,E,F | F | `spasi` |
| 7 | 1 | F | T | T | T | F | T | A,D,E | F | `spasi` |
| 7 | 2 | F | T | T | T | F | T | A,D,E | F | `spasi` |
| 7 | 3 | F | T | T | T | F | T | A,D,E | F | `spasi` |
| 7 | 4 | F | T | T | T | T | T | A,D,E,F | T | `*` |
| 7 | 5 | F | T | T | T | T | F | A,D,E,F | F | `spasi` |
| 7 | 6 | F | T | T | T | T | F | A,D,E,F | F | `spasi` |
| 7 | 7 | F | T | T | T | T | F | A,D,E,F | F | `spasi` |


Contoh i=2,j=3: A true, B true, C true; OR sudah true, D/E/F dilewati. Contoh i=5,j=1: A false, B/C dilewati; D true, E false, F dilewati; cetak spasi. `println()` tetap berjalan sekali setelah tujuh sel, termasuk sel spasi. Simulator mempertahankan spasi akhir agar perilakunya sama dengan source utama; helper pattern memangkas spasi akhir untuk memudahkan perbandingan teks.

## Pola lain dan rumus

Semua kontrak n=1..30; n di luar rentang ditolak. Kecuali butterfly berukuran lebar 2n, pola simetris memakai lebar 2n-1. Kompleksitas pola grid O(n²) waktu dan O(n²) ruang untuk string keluaran. Floyd dan Pascal juga menghasilkan Θ(n²) angka; biaya digit dibatasi n≤30. Number pyramid menuliskan angka 1..i dipisah spasi; untuk n≥10 jarak visual berubah karena jumlah digit.

| Nama CLI | Rumus / invariant | Edge case |
|---|---|---|
| triangle | j≤i: tiap baris bertambah satu | n=1 satu bintang |
| inverted-triangle | j≤n-i+1: banyak bintang berkurang satu | baris terakhir satu |
| pyramid | batas n-i+1..n+i-1 | lebar selalu ganjil |
| inverted-pyramid | batas i..2n-i | baris pertama terlebar |
| diamond | gabungan wilayah atas/bawah seperti di atas | tengah tidak diulang |
| hollow-diamond | pakai kesamaan dengan salah satu tepi | kedua tepi bertemu di ujung |
| rectangle | i=1 atau i=n atau j=1 atau j=size | n=1 seluruh baris tepi |
| x | diagonal j=i atau j=size-i+1 | pusat cukup dicetak sekali |
| butterfly | sayap kiri j≤width atau kanan j>2n-width | tengah kedua sayap bertemu |
| number-pyramid | n-i spasi lalu angka 1..i | n=1 menghasilkan 1 |
| floyd | counter naik setiap sel | baris ke-i punya i angka |
| pascal | nilai awal 1; berikutnya value*(i-j)/(j+1) | baris nol 1; batas n mencegah Long overflow |

Lihat contoh keluaran semua pola pada [contoh](examples.md) dan [latihan](../exercises/30-soal.md). Untuk hollow diamond, OR pada kedua tepi juga short-circuit: jika tepi kiri sudah cocok, tepi kanan tidak perlu diperiksa.
