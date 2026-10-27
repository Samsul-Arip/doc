# Instalasi tools dari perangkat baru

Versi baseline dan sumber resmi tercatat di [11-versi-dan-referensi.md](11-versi-dan-referensi.md). Gunakan Flutter 3.29.0 + Dart 3.7.0 untuk mereproduksi lockfile latihan, JDK 17, Node 24 LTS, Kotlin 2.1.20, MySQL 8.4 LTS. Baseline Flutter berasal dari versi yang tersedia lokal, bukan versi terbaru. Untuk produksi baru evaluasi stable terkini secara terpisah; jangan menaikkan semua dependency sebelum berhasil menjalankan baseline.

Sediakan sekitar 15 GB ruang kosong (SDK/emulator/cache dapat lebih besar), RAM 8 GB minimum praktis dan 16 GB lebih nyaman, koneksi unduh, serta virtualisasi hardware. Hindari folder proyek dengan izin administrator, folder sinkronisasi, atau path terlalu panjang. Perintah `cd` memindah folder, `pwd` (PowerShell juga mendukung) menunjukkan lokasi saat ini. Blok `bash` ditujukan macOS/Linux atau Git Bash Windows kecuali ditandai PowerShell.

## Windows 11

1. Unduh [Git for Windows](https://git-scm.com/downloads/win); instal dengan Git Bash dan Git dari command line. Buka terminal baru: `git --version`.
2. Unduh [Temurin JDK 17](https://adoptium.net/temurin/releases/?version=17), pilih Windows dan arsitektur CPU. Aktifkan penambahan JAVA_HOME/PATH saat installer menawarkannya. Verifikasi `java -version` dan `javac -version`; keduanya harus 17 untuk baseline Android ini.
3. Unduh [Android Studio](https://developer.android.com/studio), jalankan Standard setup, instal SDK/AVD sesuai [panduan berikut](02-setup-android-studio.md). Di Task Manager → Performance → CPU, Virtualization harus Enabled. Jika Disabled, aktifkan VT-x/AMD-V pada BIOS/UEFI sesuai vendor. Gunakan Windows Hypervisor Platform bila diminta emulator dan restart.
4. Unduh bundle Flutter Windows 3.29.0 dari [arsip resmi](https://docs.flutter.dev/install/archive), ekstrak ke `C:\src\flutter`. Tambahkan `C:\src\flutter\bin` ke User Path melalui Edit environment variables for your account → Path → New. Tutup/buka terminal, jalankan `where.exe flutter`, `flutter --version`, `dart --version`. Jangan memasang Dart terpisah.
5. Unduh Node **24 LTS** dari [nodejs.org](https://nodejs.org/en/download), instal MSI dengan npm, lalu `node --version` dan `npm --version`. Jika PowerShell memblokir npm.ps1, gunakan `npm.cmd`, Command Prompt, atau Git Bash; tidak perlu melonggarkan execution policy secara global.
6. Unduh MySQL Community Server 8.4 installer dari [MySQL](https://dev.mysql.com/downloads/mysql/8.4.html). Pilih standalone server, port 3306, tetapkan password root milik sendiri, dan simpan di password manager. Tambahkan direktori bin MySQL ke Path bila `mysql` tidak dikenali. Jalankan `mysql --version`, lalu `mysql -u root -p` dan `SELECT VERSION();`.
7. Workbench opsional dari [sumber resmi](https://dev.mysql.com/downloads/workbench/); server tetap wajib bila tanpa Docker. Buat koneksi localhost:3306 dengan akun lokal. Kompatibilitas Workbench terhadap server 8.4 dapat memberi peringatan; CLI tetap menjadi rujukan latihan.
8. Docker Desktop opsional dari [Docker](https://docs.docker.com/desktop/setup/install/windows-install/), ikuti prasyarat WSL2 vendor. Jalankan aplikasinya sebelum `docker version` dan `docker compose version`.
9. VS Code opsional dari [code.visualstudio.com](https://code.visualstudio.com/), pasang ekstensi Flutter (Dart ikut terpasang). `code --version` memverifikasi CLI bila opsi PATH diaktifkan.
10. Unduh compiler Kotlin 2.1.20 ZIP dari [rilis JetBrains](https://github.com/JetBrains/kotlin/releases/tag/v2.1.20), ekstrak misalnya `C:\tools\kotlinc`, tambah `C:\tools\kotlinc\bin` ke Path. `kotlinc -version` harus berhasil.

Untuk script repository pakai Git Bash, atau kompilasi Kotlin pada PowerShell:

```powershell
New-Item -ItemType Directory -Force .test-results
kotlinc kotlin-logic/basics/*.kt kotlin-logic/patterns/Patterns.kt kotlin-logic/algorithms/*.kt kotlin-logic/solutions/*.kt kotlin-logic/tests/TestMain.kt -include-runtime -d .test-results/kotlin-tests.jar
java -jar .test-results/kotlin-tests.jar
```

## macOS Apple Silicon

1. Instal command line tools dengan `xcode-select --install` jika Git belum tersedia; `git --version` memverifikasi. Full Xcode hanya dibutuhkan jika ingin menambah target iOS.
2. Unduh Temurin **JDK 17 macOS aarch64** dari Adoptium, instal PKG. ` /usr/libexec/java_home -V` menampilkan JDK; pada zsh set `export JAVA_HOME=$(/usr/libexec/java_home -v 17)` dan `export PATH="$JAVA_HOME/bin:$PATH"` dalam `~/.zshrc`. Buka terminal baru dan verifikasi `java -version`, `javac -version`.
3. Unduh Android Studio untuk Mac Apple chip. Jalankan setup wizard dan instal SDK serta emulator ARM64; jangan memilih image x86_64 pada Apple Silicon.
4. Unduh Flutter 3.29.0 macOS **arm64** dari arsip resmi. Ekstrak ke `~/develop/flutter`, lalu tambahkan `export PATH="$HOME/develop/flutter/bin:$PATH"` ke `~/.zshrc`. Buka terminal baru; `which flutter`, `flutter --version`, `dart --version`.
5. Instal Node 24 LTS melalui installer resmi yang sesuai arm64, atau version manager bila sudah memakainya. `node -v` harus 24.x. Repository memiliki `.nvmrc` berisi 24 bagi pengguna nvm; `nvm install` lalu `nvm use`.
6. Instal MySQL 8.4 macOS ARM64 DMG dari Oracle, ingat password root, dan mulai server melalui pengaturan yang disediakan installer. Jika memakai Homebrew yang sudah terpasang: `brew install mysql@8.4` dan `brew services start mysql@8.4`, lalu ikuti instruksi keamanan/password yang dicetak formula. Jangan menjalankan kedua server sekaligus. Tambahkan bin instalasi ke PATH sesuai lokasi aktual; verifikasi `mysql --version` dan `mysql -u root -p -e "SELECT VERSION();"`.
7. Workbench, Docker Desktop Apple Silicon, dan VS Code opsional melalui unduhan vendor. Docker perlu dibuka dan menampilkan engine running; `docker version` memastikan client **dan server** tersedia.
8. Unduh ZIP Kotlin 2.1.20 ke `~/tools`, ekstrak menjadi `~/tools/kotlinc`, tambah `export PATH="$HOME/tools/kotlinc/bin:$PATH"` ke `~/.zshrc`. `kotlinc -version` memverifikasi.

## Ubuntu 24.04 LTS

```bash
sudo apt update
sudo apt install git curl unzip xz-utils zip libglu1-mesa openjdk-17-jdk
java -version
javac -version
git --version
```

Unduh Android Studio Linux dari vendor dan ekstrak ke folder milik pengguna, jalankan `bin/studio.sh`. Setup wizard mengunduh SDK. Periksa virtualisasi: `lscpu` lalu cari Virtualization. Pasang KVM sesuai [panduan emulator resmi](https://developer.android.com/studio/run/emulator-acceleration), umumnya `sudo apt install qemu-kvm` dan masukkan pengguna ke grup kvm bila belum memiliki izin, lalu logout/login. Verifikasi `/dev/kvm` dapat diakses; jika CPU/VM tidak mendukung, gunakan perangkat fisik.

Unduh Flutter Linux 3.29.0 dari arsip sesuai arsitektur yang tersedia, ekstrak ke `~/develop/flutter`; tambah PATH ke `~/.bashrc`, buka terminal baru. Verifikasi `which flutter`, `flutter --version`, `dart --version`. Linux desktop build memerlukan dependency lain; latihan ini menargetkan Android.

Pasang Node 24 dari distribusi resmi atau nvm yang diverifikasi dari repositori resminya. Jangan mengasumsikan `apt install nodejs` selalu memilih versi yang sama. Jalankan `node -v` dan `npm -v`. Untuk MySQL 8.4 gunakan [MySQL APT repository](https://dev.mysql.com/downloads/repo/apt/) dan pilih seri 8.4 LTS saat konfigurasi, atau Docker. Paket bawaan Ubuntu bisa memilih 8.0: query latihan membutuhkan minimal 8.0.16. Verifikasi `mysql --version`, `systemctl status mysql`, lalu `sudo mysql -e "SELECT VERSION();"`. Akun root dapat memakai socket authentication; buat akun latihan berpassword seperti pada panduan MySQL.

Pasang Kotlin dari ZIP resmi 2.1.20 seperti macOS dengan PATH di `~/.bashrc`. Docker Desktop/Engine opsional: ikuti [instalasi resmi Ubuntu](https://docs.docker.com/engine/install/ubuntu/), lalu verifikasi daemon dengan `docker info`. Hak akses grup docker memberi kontrol besar atas host; gunakan konfigurasi vendor yang sesuai perangkat sendiri.

## Checklist verifikasi semua OS

```bash
git --version
java -version
javac -version
kotlinc -version
node --version
npm --version
mysql --version
flutter --version
dart --version
flutter doctor -v
flutter devices
docker version
docker compose version
```

Dua perintah Docker boleh dilewati bila memakai MySQL native. `adb version`, `emulator -version`, serta `sdkmanager --list` tersedia bila folder SDK platform-tools, emulator, dan cmdline-tools/latest/bin sudah ada di PATH. Android Studio → Help/About memberi versi IDE. Dart, Flutter, dan Android plugin IDE bukan pengganti instalasi SDK. Lanjutkan setup SDK pada [02](02-setup-android-studio.md), lalu [03](03-setup-flutter.md).
