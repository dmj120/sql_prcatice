-- Practice schema: customers/orders/products/order_items
CREATE TABLE IF NOT EXISTS customers (
  customer_id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  city TEXT
);
CREATE TABLE IF NOT EXISTS products (
  product_id SERIAL PRIMARY KEY,
  product_name TEXT NOT NULL,
  price NUMERIC
);
CREATE TABLE IF NOT EXISTS orders (
  order_id SERIAL PRIMARY KEY,
  customer_id INT REFERENCES customers(customer_id),
  order_date DATE,
  total_amount NUMERIC
);
CREATE TABLE IF NOT EXISTS order_items (
  order_item_id SERIAL PRIMARY KEY,
  order_id INT REFERENCES orders(order_id),
  product_id INT REFERENCES products(product_id),
  quantity INT
);

-- Seeds
INSERT INTO customers (name, city) VALUES
('Alice','Temecula'),('Bob','San Diego'),('Charlie','Las Vegas'),('Diana','Phoenix');
INSERT INTO products (product_name, price) VALUES
('Laptop',1200),('Monitor',300),('Keyboard',50),('Mouse',25),('Desk',400);
INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1,'2025-09-01',1525),(2,'2025-09-02',300),(1,'2025-09-03',400),(3,'2025-09-04',50);
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1,1,1),(1,2,1),(1,4,1),(2,2,1),(3,5,1),(4,3,1);
