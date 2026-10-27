# Versi, kompatibilitas, dan sumber resmi

Diperiksa untuk materi pada **28 Oktober 2026 (Asia/Jakarta)**. Versi dipilih untuk reproduksi dan kompatibilitas, bukan diasumsikan sebagai versi terbaru. Source dependency backend terkunci dalam package-lock.json; Flutter dalam pubspec.lock; toolchain Android pada Gradle wrapper/settings.gradle.kts.

| Komponen        | Baseline               | Alasan                                                                                                        |
| --------------- | ---------------------- | ------------------------------------------------------------------------------------------------------------- |
| Flutter / Dart  | 3.29.0 / 3.7.0         | SDK stable yang tersedia dan diuji lokal, arsip resmi menyediakan versi historis                              |
| Riverpod        | flutter_riverpod 2.6.1 | API provider sederhana kompatibel Dart3.7, dikunci untuk latihan                                              |
| HTTP Flutter    | Dio 5.8.0+1            | Kompatibel baseline dan test adapter                                                                          |
| Navigasi        | go_router 14.8.1       | Kompatibel Flutter3.29, route declarative                                                                     |
| JDK             | 17                     | Baseline Gradle/AGP proyek; jangan memakai JDK Studio baru tanpa mengecek kompatibilitas                      |
| Kotlin CLI      | 2.1.20                 | ZIP resmi, JVM17; source tidak bergantung fitur eksperimental                                                 |
| Node.js         | 24 LTS                 | Seri LTS untuk backend dan CI; mesin awal memiliki Node23 sehingga verifikasi memakai runtime Node24 terpisah |
| MySQL           | 8.4 LTS                | CHECK, CTE/window dan InnoDB; latihan memerlukan 8.0.16+                                                      |
| Express         | 5.x                    | Mendukung penerusan error async                                                                               |
| TypeScript      | 5.x                    | Strict, NodeNext ESM                                                                                          |
| Zod             | 4.x                    | Validasi input runtime, dependency diperbarui saat audit                                                      |
| Vitest / ESLint | 5.x / 10.x             | Node24, versi terkunci dengan hasil audit tanpa kerentanan saat pemeriksaan                                   |

Periksa versi patch nyata melalui `npm ls --prefix backend --depth=0`, `flutter pub deps`, `java -version`, `kotlinc -version`, dan `SELECT VERSION();`. Docker memakai tag seri mysql:8.4/node:24 agar mendapat patch, sehingga digest dapat berubah; pin digest tersendiri bila memerlukan reproduksi byte-identik.

## Sumber primer

- [Arsip Flutter](https://docs.flutter.dev/install/archive), [instalasi manual](https://docs.flutter.dev/install/manual), [setup Android](https://docs.flutter.dev/platform-integration/android/setup), [Flutter testing](https://docs.flutter.dev/testing/overview).
- [Riverpod 2.6.1](https://pub.dev/packages/flutter_riverpod/versions/2.6.1), [Dio 5.8.0+1](https://pub.dev/packages/dio/versions/5.8.0%2B1), [go_router 14.8.1](https://pub.dev/packages/go_router/versions/14.8.1). Halaman pub.dev menunjukkan ada versi yang lebih baru; perubahan major perlu migrasi dan pengujian, bukan penggantian diam-diam.
- [Jadwal rilis Node](https://nodejs.org/en/about/previous-releases), [unduh Node](https://nodejs.org/en/download), [Express error handling](https://expressjs.com/en/guide/error-handling/), [mysql2 prepared statements](https://sidorares.github.io/node-mysql2/docs/documentation/prepared-statements), [Zod](https://zod.dev/).
- [Manual MySQL 8.4](https://dev.mysql.com/doc/refman/8.4/en/), [Kotlin conditions/loops](https://kotlinlang.org/docs/control-flow.html), [Kotlin CLI](https://kotlinlang.org/docs/command-line.html), [rilis Kotlin2.1.20](https://github.com/JetBrains/kotlin/releases/tag/v2.1.20).
- [Android Emulator networking](https://developer.android.com/studio/run/emulator-networking), [akselerasi emulator](https://developer.android.com/studio/run/emulator-acceleration), [kompatibilitas Gradle/Java](https://docs.gradle.org/current/userguide/compatibility.html).
- [Git](https://git-scm.com/downloads), [Temurin17](https://adoptium.net/temurin/releases/?version=17), [Docker Compose](https://docs.docker.com/compose/), [GitHub Pages Actions](https://docs.github.com/en/pages/getting-started-with-github-pages/using-custom-workflows-with-github-pages).

Dokumentasi vendor dapat berkembang. Bila UI installer berubah, cocokkan nama fiturnya (SDK Manager, Device Manager, PATH) dan pertahankan versi baseline sebelum melakukan migrasi. Status verifikasi aktual dicatat terpisah di [laporan](12-laporan-verifikasi.md).

Formatter Kotlin memakai ktlint 1.5.0. Source DiamondMain.kt dikecualikan dari perubahan format agar contoh utama tetap mengikuti materi permintaan; semua source Kotlin lain diperiksa formatter/linter.
