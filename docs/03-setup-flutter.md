# Memeriksa Flutter dan membuka aplikasi

Flutter SDK sudah menyertakan Dart, engine, CLI, dan tool build. Ekstensi Flutter IDE memberi autocomplete/debug, tetapi tidak menggantikan SDK. Gunakan satu instalasi Flutter di PATH; `which flutter` (Windows: `where.exe flutter`) membantu menemukan instalasi ganda.

```bash
flutter --version
dart --version
flutter doctor -v
flutter devices
cd flutter-crud
flutter pub get
flutter analyze
flutter test
```

`pub get` membaca pubspec.yaml dan lockfile serta mengunduh dependency. Simpan pubspec.lock karena ini aplikasi. Peringatan dependency lebih baru tidak berarti lockfile gagal; baseline sengaja dibekukan. `flutter analyze` memeriksa source tanpa menjalankan UI. `flutter test` menjalankan unit/widget di host, tidak memerlukan emulator.

Buka folder **flutter-crud**, bukan folder android saja, dengan Android Studio → Open. Pilih SDK Flutter bila diminta. Pilih perangkat dari toolbar dan gunakan Run. Alternatif terminal:

```bash
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:3000/api
```

Hot reload `r` memperbarui UI sambil mempertahankan state; hot restart `R` mengulang aplikasi. Mengubah dart-define memerlukan stop lalu run ulang. `q` mengakhiri sesi debug. Jangan menjalankan `flutter create` untuk proyek ini karena platform Android sudah disertakan.

Jika ingin memakai Flutter stable yang lebih baru, buat branch percobaan, baca changelog Flutter/Riverpod/go_router, perbarui constraints dengan sengaja, lalu ulangi analyze, test, build, dan integration test. Jangan menghapus lockfile semata untuk menghilangkan peringatan.
