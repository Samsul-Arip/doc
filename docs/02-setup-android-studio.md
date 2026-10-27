# Android Studio, SDK, dan JDK

1. Jalankan Android Studio, selesaikan Setup Wizard → Standard. Biarkan unduhan SDK tuntas.
2. Welcome screen → More Actions → SDK Manager; dalam proyek melalui Settings → Languages & Frameworks → Android SDK (lokasi menu bisa berbeda antar rilis).
3. SDK Platforms: instal Android API **35** untuk baseline Flutter ini. API emulator boleh lebih baru, tetapi compile SDK mengikuti build proyek. SDK Tools: centang Android SDK Platform-Tools, Android SDK Build-Tools 35.0.0, Android SDK Command-line Tools (latest), dan Android Emulator. Apply, terima lisensi, tunggu selesai.
4. Catat **Android SDK Location**. Contoh Windows `%LOCALAPPDATA%\Android\Sdk`, macOS `~/Library/Android/sdk`, Linux `~/Android/Sdk`. Gunakan lokasi aktual, jangan menyalin path mesin orang lain.
5. Konfigurasikan Flutter: `flutter config --android-sdk "/path/SDK"`. Pada Windows gunakan path Windows yang sebenarnya.
6. Flutter/Gradle baseline ini cocok dengan **JDK 17**. Android Studio baru dapat membundel JDK jauh lebih baru. Periksa `flutter doctor -v`; jika Java bukan 17, set `flutter config --jdk-dir "/path/JDK17"`. Path harus direktori Home JDK, bukan file java. macOS dapat menampilkan lokasinya dengan `/usr/libexec/java_home -v 17`. Perintah konfigurasi ini berlaku untuk Flutter pengguna secara global; catat nilai sebelumnya jika mengerjakan proyek lain.
7. IDE Settings → Plugins → Marketplace → Flutter → Install; izinkan Dart plugin. Restart bila diminta. Verifikasi plugin terpasang melalui daftar Installed. Untuk Kotlin command line tetap gunakan compiler Kotlin sendiri.
8. Jalankan `flutter doctor --android-licenses`, baca dan setujui tiap lisensi sesuai kebutuhan, lalu `flutter doctor -v`.

PATH opsional agar adb/emulator bisa dipanggil langsung. Contoh zsh/bash (sesuaikan lokasi):

```bash
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
adb version
sdkmanager --list
```

Linux biasanya memakai `ANDROID_HOME="$HOME/Android/Sdk"`. Di Windows atur ANDROID_HOME ke lokasi SDK melalui Environment Variables, lalu tambahkan tiga folder tersebut ke User Path. Buka terminal baru. Hindari ANDROID_HOME dan ANDROID_SDK_ROOT yang menunjuk folder berbeda.

File `flutter-crud/android/local.properties` dibuat Flutter untuk path lokal dan diabaikan Git. Jangan mengunggahnya. Gradle wrapper menyimpan versi Gradle proyek; tidak perlu memasang Gradle global. Jika SDK meminta NDK untuk plugin/build, biarkan Gradle mengunduh versi yang dinyatakan Flutter, atau instal dari SDK Manager → Show Package Details sesuai pesan error.
