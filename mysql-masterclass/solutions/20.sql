-- Beri label Habis, Rendah (1..7), atau Cukup pada stok produk.
-- CASE memeriksa cabang berurutan dan memakai cabang benar pertama.
SELECT id, name, CASE WHEN stock = 0 THEN 'Habis' WHEN stock <= 7 THEN 'Rendah' ELSE 'Cukup' END AS stock_label FROM products ORDER BY id;
