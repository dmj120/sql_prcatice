-- 1) Inner join: orders with customer names
SELECT o.order_id, c.name, o.total_amount
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id;

-- 2) Multi-table join: what each customer bought
SELECT c.name, p.product_name, oi.quantity, o.order_date
FROM customers c
JOIN orders o       ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id    = o.order_id
JOIN products p     ON p.product_id   = oi.product_id
ORDER BY c.name, o.order_id;

-- 3) Left join: all customers, orders if any
SELECT c.name, o.order_id, o.total_amount
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
ORDER BY c.name;

-- 4) Full outer: show customers w/o orders and orders w/o customers (if any)
SELECT c.name, o.order_id
FROM customers c
FULL OUTER JOIN orders o ON o.customer_id = c.customer_id
ORDER BY COALESCE(c.name,'~'), COALESCE(o.order_id,0);

-- 5) Anti-join: customers with no orders
SELECT c.*
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
WHERE o.order_id IS NULL;

-- 6) Aggregation with joins: total items per customer
SELECT c.name, SUM(oi.quantity) AS total_items
FROM customers c
JOIN orders o       ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id    = o.order_id
GROUP BY c.name
ORDER BY total_items DESC NULLS LAST, c.name;

-- 7) Having: customers who bought >= 2 items total
SELECT c.name, SUM(oi.quantity) AS total_items
FROM customers c
JOIN orders o       ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id    = o.order_id
GROUP BY c.name
HAVING SUM(oi.quantity) >= 2;

-- 8) Price filter across joins: buyers of products > $100
SELECT DISTINCT c.name
FROM customers c
JOIN orders o       ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id    = o.order_id
JOIN products p     ON p.product_id   = oi.product_id
WHERE p.price > 100;
