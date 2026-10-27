# Membuat AVD dan menyalakan emulator

1. Buka Android Studio. Welcome → More Actions → Virtual Device Manager; jika proyek terbuka pilih Tools → Device Manager.
2. Klik **Create device**, pilih profil telepon (misalnya Pixel), Next.
3. Pilih system image Android API 35 Google APIs yang cocok CPU. Apple Silicon memakai **arm64-v8a**. PC Intel/AMD memakai x86_64. Klik Download bila belum terpasang dan tunggu selesai, lalu Next.
4. Beri nama yang mudah dikenali, pakai default graphics hardware/automatic. Finish.
5. Klik tombol ▶ di Device Manager. Tunggu sampai layar Android home muncul; boot pertama bisa beberapa menit. Jangan menutup jendela emulator selama menjalankan Flutter.
6. Di terminal jalankan:

```bash
flutter emulators
flutter devices
adb devices
```

`flutter devices` harus menampilkan `emulator-5554` atau id sejenis dengan platform android. Jika ada beberapa perangkat, selalu pilih `-d <DEVICE_ID>`. Contoh:

```bash
cd flutter-crud
flutter run -d emulator-5554 --dart-define=API_BASE_URL=http://10.0.2.2:3000/api
```

CLI opsional: `flutter emulators --launch <EMULATOR_ID>` memakai id dari `flutter emulators`, **berbeda** dengan device id dari `flutter devices`. Tunggu boot lalu cek devices lagi. Untuk menutup cukup tutup jendela AVD; jangan hapus data AVD bila masih dibutuhkan.

## Jalur jaringan

| Perangkat                       | API_BASE_URL development        | Alasan                                                               |
| ------------------------------- | ------------------------------- | -------------------------------------------------------------------- |
| Android Emulator standar        | http://10.0.2.2:3000/api        | 10.0.2.2 alias loopback komputer host                                |
| iOS Simulator                   | http://127.0.0.1:3000/api       | Simulator memakai jaringan host, target iOS belum disertakan         |
| Android fisik Wi-Fi             | http://IP_LAN_KOMPUTER:3000/api | Ponsel dan komputer harus satu LAN; localhost ponsel menunjuk ponsel |
| Android fisik USB + adb reverse | http://127.0.0.1:3000/api       | Jalankan `adb reverse tcp:3000 tcp:3000` dahulu                      |

Pada perangkat fisik izinkan firewall TCP 3000 hanya sesuai LAN development dan pastikan backend bind 0.0.0.0. Untuk iOS simulator bila menambahkan target iOS, siapkan Xcode dan izin ATS development bila memakai HTTP; rilis tetap HTTPS. Pada emulator Android, buka Chrome dan kunjungi `http://10.0.2.2:3000/ready` untuk memisahkan masalah jaringan dari aplikasi.

Izin internet pada manifest utama, HTTP cleartext hanya manifest debug. Build release menolak HTTP lokal secara default: ini sebab base URL debug tidak bisa dipakai sembarangan pada release. Jangan mengatasi error release dengan mengaktifkan cleartext global; gunakan HTTPS valid.

Jika emulator tidak bisa dipakai, perangkat Android fisik dapat menjalankan alur yang sama. Android Emulator memerlukan akselerasi CPU dan RAM cukup; jalankan satu AVD dahulu. Cold Boot dapat mengatasi snapshot rusak, sedangkan Wipe Data menghapus data emulator dan dipakai hanya bila memang perlu.
