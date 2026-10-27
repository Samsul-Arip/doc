-- Gunakan database latihan terpisah; seluruh waktu disimpan dalam UTC.
CREATE TABLE departments (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(80) NOT NULL UNIQUE
) ENGINE=InnoDB;
CREATE TABLE employees (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  department_id INT NOT NULL,
  manager_id INT NULL,
  salary DECIMAL(12,2) NOT NULL CHECK (salary >= 0),
  FOREIGN KEY (department_id) REFERENCES departments(id),
  FOREIGN KEY (manager_id) REFERENCES employees(id)
) ENGINE=InnoDB;
CREATE TABLE categories (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(80) NOT NULL UNIQUE
) ENGINE=InnoDB;
CREATE TABLE products (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(120) NOT NULL,
  sku VARCHAR(40) NOT NULL UNIQUE,
  category_id INT NOT NULL,
  price DECIMAL(12,2) NOT NULL CHECK (price >= 0),
  stock INT NOT NULL CHECK (stock >= 0),
  created_at DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  updated_at DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  FOREIGN KEY (category_id) REFERENCES categories(id),
  INDEX idx_products_category_id (category_id, id)
) ENGINE=InnoDB;
CREATE TABLE customers (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  city VARCHAR(80) NOT NULL,
  phone VARCHAR(25) NULL
) ENGINE=InnoDB;
CREATE TABLE orders (
  id INT PRIMARY KEY AUTO_INCREMENT,
  customer_id INT NOT NULL,
  status ENUM('pending','paid','cancelled') NOT NULL,
  ordered_at DATETIME NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customers(id),
  INDEX idx_orders_status_date (status, ordered_at)
) ENGINE=InnoDB;
CREATE TABLE order_items (
  id INT PRIMARY KEY AUTO_INCREMENT,
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL CHECK (quantity > 0),
  unit_price DECIMAL(12,2) NOT NULL CHECK (unit_price >= 0),
  FOREIGN KEY (order_id) REFERENCES orders(id),
  FOREIGN KEY (product_id) REFERENCES products(id),
  UNIQUE KEY uq_order_product (order_id, product_id)
) ENGINE=InnoDB;
