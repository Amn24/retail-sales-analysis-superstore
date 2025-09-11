-- ==========================================
-- Retail Sales Analysis - Superstore Dataset
-- Author: Aman Singh
-- ==========================================

-- 1. Row Count (sanity check)
SELECT COUNT(*) AS total_rows
FROM retail_sales;

-- 2. Unique Customers
SELECT COUNT(DISTINCT "Customer ID") AS unique_customers
FROM retail_sales;

-- 3. Total Revenue
SELECT SUM(Sales) AS total_revenue
FROM retail_sales;

-- 4. Monthly Revenue Trend
SELECT strftime('%Y-%m', "Order Date") AS month,
       SUM(Sales) AS monthly_revenue
FROM retail_sales
GROUP BY month
ORDER BY month;

-- 5. Top 10 Products by Revenue
SELECT "Product Name",
       SUM(Sales) AS total_revenue
FROM retail_sales
GROUP BY "Product Name"
ORDER BY total_revenue DESC
LIMIT 10;

-- 6. Repeat vs One-time Customers
WITH orders_per_customer AS (
    SELECT "Customer ID",
           COUNT(DISTINCT "Order ID") AS order_count
    FROM retail_sales
    GROUP BY "Customer ID"
)
SELECT CASE WHEN order_count > 1 THEN 'Repeat'
            ELSE 'One-time'
       END AS customer_type,
       COUNT(*) AS customer_count
FROM orders_per_customer
GROUP BY customer_type;

-- 7. Average Basket Size (items per order)
SELECT AVG(order_quantity) AS avg_basket_size
FROM (
    SELECT "Order ID",
           SUM(Quantity) AS order_quantity
    FROM retail_sales
    GROUP BY "Order ID"
);
