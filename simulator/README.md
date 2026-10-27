# Logic Lab

Buka `index.html` langsung di browser, atau dari root: `python3 -m http.server 8080 --directory simulator`, lalu buka http://localhost:8080. CSS punya font fallback sehingga simulator tetap bekerja offline. Google Fonts hanya mempercantik tipografi bila internet tersedia.

Pilih empat pola, n=1..10, lalu Step Forward/Back, Reset atau Run to End. Kode penuh diberi nomor; highlight mengikuti instruksi aktif. Panel Boolean menandai operand yang belum diperiksa, true/false, dan dilewati. Console baru berubah saat event print atau println, bukan saat kondisi diperiksa.

`engine.js` membangun snapshot immutable per event dari AST kondisi. Semua kondisi dievaluasi dari kiri ke kanan dengan short circuit. Bagian antarmuka di `app.js` hanya merender snapshot, sehingga Step Back mengembalikan output/variabel persis ke keadaan sebelumnya. Mesin ini menjelaskan source yang ditampilkan dan tidak mengeksekusi kode Kotlin bebas. Alokasi runtime, call stack, dan internal iterator tidak dimodelkan.

Mode latihan menyembunyikan source, kondisi, bintang, serta console sebelum solusi dibuka. Peserta memprediksi total bintang dan dapat memeriksa jawaban tanpa membuka solusi.

Tes: `node --test simulator/tests/*.test.cjs` dari root. Test memeriksa hasil pola, urutan operand yang dievaluasi, instruksi print/newline terpisah, dan batas n. GitHub Pages memakai workflow `pages.yml`; atur Settings → Pages → Source → GitHub Actions setelah repo dibuat public. Halaman statis tidak memerlukan backend atau login.
