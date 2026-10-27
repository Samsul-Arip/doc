START TRANSACTION;
INSERT INTO departments (id,name) VALUES (1,'Engineering'),(2,'Sales'),(3,'HR'),(4,'Support');
INSERT INTO employees (id,name,department_id,manager_id,salary) VALUES
(1,'Ayu',1,NULL,12000000),(3,'Citra',2,NULL,9000000),(5,'Eka',3,NULL,8000000);
INSERT INTO employees (id,name,department_id,manager_id,salary) VALUES
(2,'Bima',1,1,10000000),(4,'Dedi',2,3,9000000),(6,'Fajar',1,1,10000000);
INSERT INTO categories (id,name) VALUES (1,'Elektronik'),(2,'Aksesori'),(3,'ATK'),(4,'Furniture');
INSERT INTO products (id,name,sku,category_id,price,stock,created_at,updated_at) VALUES
(1,'Laptop','LAP-01',1,12000000,5,'2026-01-01','2026-01-01'),
(2,'Monitor','MON-01',1,2500000,8,'2026-01-01','2026-01-01'),
(3,'Keyboard','KEY-01',2,350000,20,'2026-01-01','2026-01-01'),
(4,'Mouse','MOU-01',2,150000,0,'2026-01-01','2026-01-01'),
(5,'Buku','BUK-01',3,25000,50,'2026-01-01','2026-01-01'),
(6,'Pulpen','PEN-01',3,5000,100,'2026-01-01','2026-01-01'),
(7,'Headset','HEA-01',2,500000,7,'2026-01-01','2026-01-01'),
(8,'Webcam','WEB-01',1,700000,3,'2026-01-01','2026-01-01');
INSERT INTO customers (id,name,city,phone) VALUES
(1,'Andi','Jakarta','0811111111'),(2,'Bella','Bandung',NULL),(3,'Chandra','Jakarta','0833333333'),(4,'Dina','Surabaya','0844444444'),(5,'Eko','Bogor',NULL);
INSERT INTO orders (id,customer_id,status,ordered_at) VALUES
(1,1,'paid','2026-01-01 10:00:00'),(2,2,'paid','2026-01-02 11:00:00'),(3,1,'pending','2026-01-03 12:00:00'),
(4,3,'cancelled','2026-01-04 13:00:00'),(5,4,'paid','2026-01-05 14:00:00'),(6,2,'paid','2026-02-01 10:00:00');
INSERT INTO order_items (id,order_id,product_id,quantity,unit_price) VALUES
(1,1,1,1,12000000),(2,1,3,2,350000),(3,2,2,1,2500000),(4,2,4,1,150000),
(5,3,5,4,25000),(6,4,6,10,5000),(7,5,3,1,350000),(8,5,7,1,500000),
(9,6,5,10,25000),(10,6,6,20,5000);
COMMIT;
