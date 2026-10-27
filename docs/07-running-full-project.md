# Dari clone hingga CRUD di Android Emulator

Semua perintah dimulai dari root repository kecuali ada `cd`. Repository tujuan adalah `Samsul-Arip/doc`; nama folder clone dipilih secara eksplisit agar mengikuti struktur panduan.

```bash
git clone https://github.com/Samsul-Arip/doc.git mobile-developer-technical-test-masterclass
cd mobile-developer-technical-test-masterclass
```

Jika memakai ZIP, ekstrak lalu buka terminal dalam folder berisi README.md. Gunakan Git Bash untuk blok bash di Windows. Persiapan tools di [01](01-install-tools.md), SDK [02](02-setup-android-studio.md).

## Jalur A: MySQL + API lewat Docker

```bash
cp .env.example .env
```

Edit .env dan ganti password placeholder, lalu:

```bash
docker compose up -d --build
docker compose ps
curl http://localhost:3000/health
curl http://localhost:3000/ready
curl http://localhost:3000/api/categories
```

MySQL otomatis membuat schema/seed pada volume pertama. Tunggu ready HTTP 200, bukan sekadar container running. `docker compose logs --tail=100 backend mysql` membantu diagnosis. Jangan menjalankan server native di port sama.

## Jalur B: tanpa Docker

1. Buat database/user melalui [04](04-setup-mysql.md). Import schema dan seed:

```bash
mysql -u root -p < mysql-masterclass/schema/00-database.sql
mysql -u root -p masterclass < mysql-masterclass/schema/01-tables.sql
mysql -u root -p masterclass < mysql-masterclass/seed/02-seed.sql
cd backend
cp .env.example .env
```

2. Edit backend/.env, sesuaikan host/user/password dengan database lokal, lalu:

```bash
npm ci
npm run dev
```

3. Biarkan terminal server terbuka. Terminal kedua di root:

```bash
curl http://localhost:3000/health
curl http://localhost:3000/ready
curl http://localhost:3000/api/products
```

PowerShell memakai `curl.exe` dan import melalui SOURCE, seperti panduan MySQL. Hasil list seed pertama mempunyai 8 produk dan totalPages 1.

## Android Studio sampai Flutter

4. Buka Android Studio → Device Manager → Create device, pilih image sesuai CPU, unduh API 35, Finish. Klik Play dan tunggu Android home. Panduan gambar menu secara tertulis ada di [06](06-running-emulator.md).
5. Pada terminal root:

```bash
flutter doctor -v
flutter devices
cd flutter-crud
flutter pub get
flutter analyze
flutter test
flutter run -d <DEVICE_ID> --dart-define=API_BASE_URL=http://10.0.2.2:3000/api
```

Ganti `<DEVICE_ID>` dengan id Android dari `flutter devices`. Jika hanya satu target Android, Flutter dapat memilihnya, tetapi penulisan eksplisit lebih jelas. Jika doctor menunjukkan Java bawaan Studio terlalu baru untuk Gradle, arahkan Flutter ke JDK17 sesuai [02](02-setup-android-studio.md).

## Uji CRUD yang dapat diamati

6. Pastikan delapan produk seed tampil. Cari `key`, hasil Keyboard. Pilih Aksesori; coba tarik daftar ke bawah untuk refresh. Kosongkan search dan filter sebelum membuat produk.
7. Tap Tambah produk. Kosongkan field lalu Simpan: tampil error validasi. Isi nama `Barang Belajar`, SKU `BELAJAR-UNIK-01`, kategori Elektronik, harga `12500,50`, stok `3`. Simpan → detail menampilkan stok 3.
8. Periksa database: `SELECT id,name,sku,price,stock FROM products WHERE sku='BELAJAR-UNIK-01';` memastikan data tersimpan setelah restart aplikasi.
9. Tap Edit produk, ubah stok menjadi 7 dan harga 15000, Simpan. Detail dan daftar harus ikut berubah.
10. Tap Hapus produk → Batal, produk tetap ada. Tap lagi → Hapus, kembali ke daftar. Query SKU tersebut kini tidak mengembalikan baris.
11. Coba tambah SKU yang sudah ada (`LAP-01`) → konflik 409 ditampilkan. Hapus Laptop seed → ditolak karena ada riwayat order, bukan diam-diam menghapus pesanan.
12. Hentikan API untuk melihat error koneksi; mulai API lalu Coba lagi. Filter Furniture menghasilkan empty state. Pull to refresh tetap bisa pada list kosong.

## Test dan build

Dari flutter-crud, saat emulator dan API aktif:

```bash
flutter test integration_test/crud_test.dart -d <DEVICE_ID> --dart-define=API_BASE_URL=http://10.0.2.2:3000/api
flutter build apk --debug
```

Integration test membuat produk IT- unik lalu menghapusnya; gunakan hanya database latihan. APK debug berada di `build/app/outputs/flutter-apk/app-debug.apk`. Build tidak sama dengan uji perangkat; laporkan keduanya terpisah. Debug bukan APK distribusi production.

Dari root, jalur lain:

```bash
bash scripts/kotlin.sh test
node --test simulator/tests/*.test.cjs
npm ci --prefix backend
npm run lint --prefix backend
npm test --prefix backend
npm run build --prefix backend
```

Untuk tes database nyata dan expected SQL, ikuti variabel environment pada [04](04-setup-mysql.md) dan [05](05-setup-backend.md). `MYSQL_TEST=1` mengaktifkan tes yang secara default skipped.

Simulator dibuka langsung melalui `simulator/index.html` atau `python3 -m http.server 8080 --directory simulator`. Buka http://localhost:8080, pilih n dan pola, coba Step/Back/Run to End serta mode latihan.

Selesai belajar: hentikan `flutter run` dengan q, server npm dengan Ctrl+C, emulator lewat jendelanya. `docker compose down` menghentikan stack Docker sambil mempertahankan volume data.
