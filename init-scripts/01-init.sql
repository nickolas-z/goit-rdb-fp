-- Initial database setup for goit-rdb-hw-02
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE USER IF NOT EXISTS 'dbuser'@'%' IDENTIFIED BY 'dbpassword';
GRANT ALL PRIVILEGES ON `goit-rdb-hw-02`.* TO 'dbuser'@'%';
FLUSH PRIVILEGES;

ALTER DATABASE `goit-rdb-hw-02` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `goit-rdb-hw-02`;

-- Clients table
CREATE TABLE IF NOT EXISTS clients (
    client_id INT AUTO_INCREMENT PRIMARY KEY,
    client_name VARCHAR(100) NOT NULL,
    client_address VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Products table
CREATE TABLE IF NOT EXISTS products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Orders table 
CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY,
    client_id INT NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (client_id) REFERENCES clients(client_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Order items table
CREATE TABLE IF NOT EXISTS order_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert data 
INSERT INTO clients (client_name, client_address) VALUES
('Мельник', 'Хрещатик 1'),
('Шевченко', 'Басейна 2'),
('Коваленко', 'Комп\'ютерна 3');

INSERT INTO products (product_name) VALUES
('Лептоп'),
('Мишка'),
('Принтер');

INSERT INTO orders (order_id, client_id, order_date) VALUES
(101, 1, '2023-03-15'),
(102, 2, '2023-03-16'),
(103, 3, '2023-03-17');

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(101, 1, 3),  -- Лептоп: 3
(101, 2, 2),  -- Мишка: 2
(102, 3, 1),  -- Принтер: 1
(103, 2, 4);  -- Мишка: 4

-- Create indexes for better performance
CREATE INDEX idx_orders_client_id ON orders(client_id);
CREATE INDEX idx_order_items_order_id ON order_items(order_id);
CREATE INDEX idx_order_items_product_id ON order_items(product_id);

-- Show tables structure
SHOW TABLES;
