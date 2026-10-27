# Kotlin Logic Masterclass

Mulai dari [dasar](basics/README.md), lanjut [rumus 12 pola + trace lengkap diamond](patterns/README.md), lalu [algoritma](algorithms/README.md). Kerjakan [30 latihan](exercises/30-soal.md) sebelum membuka [pembahasan](solutions/README.md).

Prasyarat JDK 17 dan compiler Kotlin 2.1.20; tidak memerlukan Android Studio untuk modul ini. Cara pemasangan ada di [instalasi](../docs/01-install-tools.md). Dari root repository:

```bash
bash scripts/kotlin.sh basics
bash scripts/kotlin.sh diamond 4
bash scripts/kotlin.sh hollow-diamond 4
bash scripts/kotlin.sh algorithms
bash scripts/kotlin.sh test
```

Pada Windows gunakan Git Bash untuk script tersebut atau `kotlinc` langsung melalui PowerShell (lihat panduan instalasi). Hasil jar berada di `.test-results` dan tidak masuk Git. Input negatif atau terlalu besar ditolak fungsi; CLI nilai n non-angka memakai default 4 untuk demo. Simulator visual dibuka dari `simulator/index.html` tanpa instalasi dependency.

Pola cetak di `Patterns.kt` mengembalikan string sehingga mudah diuji. `DiamondMain.kt` mempertahankan source belajar utama yang mencetak setiap sel, termasuk spasi akhir. Kedua versi memakai batas conditional yang sama dan tidak memakai abs().
