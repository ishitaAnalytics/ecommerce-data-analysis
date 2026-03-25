-- =========================
-- DATA SETUP
-- =========================
CREATE TABLE orders (
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    order_status VARCHAR(20),
    order_purchase_timestamp DATETIME
);

-- =========================
-- E-COMMERCE DATA ANALYSIS
-- =========================

-- =========================
-- REVENUE ANALYSIS
-- =========================
-- Insight: Track revenue trend over time

SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month,
    SUM(p.payment_value) AS revenue
FROM olist_project.orders o
JOIN olist_project.payments p
     ON o.order_id=p.order_id
GROUP BY month
ORDER BY month;

-- =========================
-- TOP CUSTOMERS
-- =========================
-- Insight: Identify high-value customers

SELECT
    o.customer_id,
    COUNT(o.order_id) AS total_orders,
    SUM(p.payment_value) AS total_spent
FROM olist_project.orders o
JOIN olist_project.payments p
    ON o.order_id = p.order_id
GROUP BY o.customer_id
ORDER BY total_spent DESC
LIMIT 10;
   
-- =========================
-- PAYMENT METHOD ANALYSIS
-- =========================
-- Insight: Understand preferred payment methods

SELECT
    p.payment_type,
    COUNT(*) AS total_transactions,
    SUM(p.payment_value) AS total_revenue
FROM olist_project.payments p
GROUP BY p.payment_type;
   
-- =========================
-- ORDER STATUS ANALYSIS
-- =========================
--Insight: Delivery performance and order distribution

SELECT
    o.order_status,
    COUNT(*) AS total_orders
FROM olist_project.orders o
GROUP BY o.order_status;
   
-- =========================
-- AVERAGE ORDER VALUE
-- =========================
--Insight: Understand customer spending behaviour

SELECT
    AVG(p.payment_value) AS avg_order_value
FROM olist_project.payments p;  
   
-- =========================
-- CUSTOMER SEGMENTATION
-- =========================
--Insight: Classify users based on spending

SELECT 
    CASE 
        WHEN p.payment_value > 500 THEN 'High Value'
        WHEN p.payment_value BETWEEN 200 AND 500 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment,
    COUNT(*) AS total_orders
FROM olist_project.payments p
GROUP BY customer_segment;

-- =========================
-- MONTHLY ORDER COUNT
-- =========================
--Insight: Analyze order volume trends over time

SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month,
    COUNT(*) AS total_orders
FROM olist_project.orders o
GROUP BY month
ORDER BY month;
