-- DESTRUKTIF: hanya jalankan pada database masterclass lokal/CI.
USE masterclass;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
SOURCE mysql-masterclass/schema/01-tables.sql;
SOURCE mysql-masterclass/seed/02-seed.sql;
