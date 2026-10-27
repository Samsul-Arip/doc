# Menjalankan REST API

Prasyarat Node **24 LTS**, npm, dan database dari panduan sebelumnya. `.nvmrc` disediakan bagi nvm; Node 23 yang mungkin terpasang pada mesin lain bukan baseline yang dipakai CI.

```bash
cd backend
cp .env.example .env
npm ci
```

PowerShell: `Copy-Item .env.example .env`. Isi DB_HOST=127.0.0.1, DB_PORT=3306, DB_USER=inventory, DB_PASSWORD milikmu, DB_NAME=masterclass. Jangan menambahkan kutip yang tidak perlu; jika password memakai `#` atau spasi, quote nilainya sesuai sintaks dotenv. File dibaca relatif working directory **backend**.

```bash
npm run dev
```

Biarkan terminal ini berjalan. Terminal kedua:

```bash
curl http://localhost:3000/health
curl http://localhost:3000/ready
curl 'http://localhost:3000/api/products?page=1&limit=20&search=key&categoryId=2'
curl http://localhost:3000/api/products/3
curl http://localhost:3000/api/categories
```

Gunakan `curl.exe` di PowerShell. Health `{"status":"ok"}` tidak membuktikan DB siap; `/ready` harus `{"status":"ready"}`. Server bind 0.0.0.0 agar perangkat fisik pada LAN dapat mengaksesnya. Batasi firewall sesuai jaringan development.

Contoh mutation dari bash (produk baru tanpa relasi pesanan bisa dihapus):

```bash
curl -i -X POST http://localhost:3000/api/products \
  -H 'Content-Type: application/json' \
  -d '{"name":"Produk Belajar","sku":"BELAJAR-01","categoryId":1,"price":12500.50,"stock":3}'
```

Catat `data.id` respons. Ganti `<ID>` pada contoh berikut dengan angka aktual:

```bash
curl -i -X PUT http://localhost:3000/api/products/<ID> \
  -H 'Content-Type: application/json' \
  -d '{"name":"Produk Belajar Edit","sku":"BELAJAR-01","categoryId":1,"price":15000,"stock":7}'
curl -i -X DELETE http://localhost:3000/api/products/<ID>
```

`<ID>` adalah placeholder, jangan ditempel ke shell tanpa diganti. Untuk PowerShell lebih mudah gunakan file JSON: `curl.exe -X POST ... -H "Content-Type: application/json" --data-binary "@payload.json"`.

## Kontrak respons

List: `{data:[Product],meta:{page,limit,total,totalPages}}`. Detail/create/update: `{data:Product}`. Kategori: `{data:[{id,name}]}`. Error: `{error:{message,details?}}`. createdAt/updatedAt ISO 8601 UTC, price angka, stock integer. page 1..100000, limit 1..100; search maksimal 120 karakter dan diperlakukan substring literal. PUT mengganti semua field writable, bukan patch parsial.

| Endpoint                 | Hasil                                          |
| ------------------------ | ---------------------------------------------- |
| GET /api/products        | 200, pagination/search/categoryId              |
| GET /api/products/:id    | 200 atau 404                                   |
| POST /api/products       | 201 + Location                                 |
| PUT /api/products/:id    | 200, 404 bila tidak ada                        |
| DELETE /api/products/:id | 204 tanpa body; 409 jika masih ada order_items |
| GET /api/categories      | 200                                            |
| GET /health              | 200 jika proses HTTP hidup                     |
| GET /ready               | 200 DB tersedia, 503 DB gagal                  |

Validasi 400: field kosong, tipe salah, id invalid, harga negatif/>2 desimal, stok bukan integer. Konflik SKU 409, endpoint hilang 404, JSON rusak 400, payload >32KB 413, kegagalan internal 500 tanpa SQL/stack trace.

## Struktur dan pemeriksaan

Route mendefinisikan URL; controller membaca/validasi request; service menangani aturan not found; repository berisi query parameterized; config memeriksa environment; errors memetakan error secara terpusat. Express 5 meneruskan rejection async ke middleware. Pool dibatasi 10 koneksi dan queue 100, timezone UTC, password hanya dari env. Pino mencatat request/status; Authorization/Cookie disamarkan. SIGINT/SIGTERM menghentikan HTTP lalu menutup pool dengan deadline.

```bash
npm run format:check
npm run lint
npm test
npm run build
npm start
```

Test biasa memakai fake repository untuk menguji HTTP, tidak membutuhkan MySQL. Aktifkan integrasi nyata dari **backend**: `MYSQL_TEST=1 DB_HOST=127.0.0.1 DB_PORT=3306 DB_USER=inventory DB_NAME=masterclass DB_PASSWORD=<PASSWORD_LOKAL> npm test`. Untuk menghindari history password, isi environment lewat prompt seperti panduan SQL. Tes integrasi melakukan CRUD dan pembersihan produk test; seed asli diperlukan untuk tes foreign key. Saat MYSQL_TEST bukan 1, dua tes database dilewati secara eksplisit.

Docker menjalankan build TypeScript dan `node dist/server.js`, bukan tsx watch. Gunakan backend/.env untuk native; Compose memakai .env root dan mengatur DB_HOST=mysql secara internal.
