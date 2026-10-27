-- Jalankan pada database masterclass; contoh mutation di-rollback.
START TRANSACTION;
INSERT INTO products (name,sku,category_id,price,stock) VALUES ('Produk Latihan','LAT-01',1,10000,2);
UPDATE products SET stock = stock + 1 WHERE sku = 'LAT-01';
SELECT name, stock FROM products WHERE sku = 'LAT-01'; -- stok 3
DELETE FROM products WHERE sku = 'LAT-01';
ROLLBACK;
-- DDL melakukan implicit commit di MySQL. Jangan menggabungkannya dengan transaksi DML.
CREATE TEMPORARY TABLE demo_types (id INT PRIMARY KEY, title VARCHAR(50), amount DECIMAL(10,2));
ALTER TABLE demo_types ADD COLUMN active BOOLEAN NOT NULL DEFAULT TRUE;
DROP TEMPORARY TABLE demo_types;
