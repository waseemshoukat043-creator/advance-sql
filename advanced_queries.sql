
-- Day 23: Advanced SQL
-- Project: Orders and Customers Search

-- 1. Display all orders
SELECT
    id,
    customer_name,
    customer_email,
    product_name,
    amount
FROM public.orders;

-- 2. Search for laptop orders
SELECT
    id,
    customer_name,
    product_name
FROM public.orders
WHERE product_name ILIKE '%laptop%';

-- 3. JOIN Orders and Customers
SELECT
    o.id AS order_id,
    o.customer_name AS order_customer_name,
    c.name AS customer_name,
    c.email AS customer_email,
    o.product_name,
    o.amount
FROM public.orders AS o
LEFT JOIN public.customers AS c
    ON LOWER(o.customer_email) = LOWER(c.email);

-- 4. Full-Text Search
SELECT
    id,
    customer_name,
    product_name,
    amount
FROM public.orders
WHERE to_tsvector(
    'english',
    COALESCE(customer_name, '') || ' ' ||
    COALESCE(product_name, '')
) @@ plainto_tsquery('english', 'laptop');
