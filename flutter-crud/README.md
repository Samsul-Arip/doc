# Inventory Management

Flutter 3.29.0 / Dart 3.7.0 menjadi baseline kompatibilitas yang dipakai di lingkungan pengerjaan. Versi ini **bukan klaim versi terbaru**. Dependency dikunci di pubspec.yaml dan pubspec.lock agar latihan konsisten; lihat [versi dan sumber](../docs/11-versi-dan-referensi.md).

```bash
flutter pub get
flutter analyze
flutter test
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:3000/api
```

Jalankan perintah dari folder `flutter-crud`. API dan database harus siap. Lihat [tutorial lengkap](../docs/07-running-full-project.md).

## Arsitektur feature-first

- `lib/core/api_client.dart`: konfigurasi Dio, timeout, error yang aman, provider HTTP.
- `lib/features/inventory/data`: model/decoder JSON, data source HTTP, repository yang mengubah payload menjadi model.
- `lib/features/inventory/state`: provider dependency, filter, halaman, AsyncValue daftar/detail/kategori.
- `lib/features/inventory/presentation`: halaman list, detail, form, dan widget bersama.
- `lib/app.dart`: route go_router dan tema. `main.dart` memasang ProviderScope.

Alur: UI → provider/repository → data source → Dio → REST → MySQL. UI tidak punya SQL atau password database. Interface repository hanya satu agar test dapat memasang fake tanpa HTTP. Tidak ada use-case class per tombol atau code generation yang menambah beban belajar.

## Alasan dependency

Riverpod menyuntikkan dependency dan mengelola state async; `FutureProvider.autoDispose` mengabaikan hasil request lama saat filter berubah. Dio menyediakan HTTP, timeout, dan kategori error. go_router menata route daftar/detail/form dan tombol kembali. Tidak perlu dependency serialisasi karena model kecil memakai decoder eksplisit yang menolak respons rusak. `flutter_lints`, `flutter_test`, dan `integration_test` dipakai untuk pemeriksaan kualitas.

Pencarian memiliki debounce 350 ms; kategori/pencarian kembali ke halaman 1. Pagination 20 produk per halaman. Pull to refresh tersedia termasuk saat hasil kosong. Setelah simpan, list dan detail diinvalidasi; setelah hapus, daftar kembali ke halaman 1. Form mengizinkan harga nol dan stok nol, membatasi desimal, dan mencegah submit ganda. Konflik SKU serta foreign key menampilkan pesan API.

Untuk nominal keuangan besar/akuntansi produksi, gunakan integer satuan terkecil/decimal library secara end-to-end; latihan ini membatasi harga dan dua desimal, MySQL menyimpan DECIMAL(12,2).

## Pengujian

`flutter test`: decoder, kontrak repository HTTP, loading/empty/error/retry, validasi dan penyimpanan form. `flutter test integration_test/crud_test.dart -d <DEVICE_ID> --dart-define=API_BASE_URL=http://10.0.2.2:3000/api` memerlukan emulator aktif serta backend MySQL nyata, dan melakukan create/detail/edit/delete. Tes memakai SKU unik; jika terhenti, bersihkan produk berawalan IT- dari database latihan.

Android platform dihasilkan oleh `flutter create`, termasuk Gradle wrapper. INTERNET ada di manifest utama, izin HTTP lokal hanya di manifest debug. Release membutuhkan API HTTPS dan signing milik sendiri. Build debug: `flutter build apk --debug`. Release `flutter build apk --release --dart-define=API_BASE_URL=https://api.example.com/api`; jangan mendistribusikan sebelum signing dan konfigurasi produksi ditetapkan. Proyek ini menargetkan Android; iOS perlu `flutter create --platforms=ios .` dan Xcode, lalu konfigurasi izin jaringan development tersendiri bila memakai HTTP.
