-- TOP 10 miast z największą liczbą klientów
SELECT customer_city, COUNT(*) AS total_customers
FROM customers
GROUP BY customer_city
ORDER BY total_customers DESC
LIMIT 10;

-- TOP 10 kategorii produktów pod względem przychodu
SELECT p.product_category_name,
    COUNT(oi.order_id) AS total_orders,
    ROUND(SUM(oi.price)::numeric, 2) AS total_revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_revenue DESC
LIMIT 10;

-- Podział zamówień według typu płatności
SELECT payment_type,
    COUNT(*) AS total_transactions,
    ROUND(SUM(payment_value)::NUMERIC, 2) AS total_paid_value
FROM order_payments
WHERE payment_type != 'not_defined' AND payment_value > 0
GROUP BY payment_type
ORDER BY total_transactions DESC;

-- Analiza statusu dostaw: na czas vs spóźnione
SELECT 
    CASE
        WHEN order_delivered_customer_date <= order_estimated_delivery_date THEN 'On time'
        WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 'Late'
        ELSE 'Missing Data'
        END AS delivery_performance,
    COUNT(*) AS total_orders,
    ROUND(AVG(EXTRACT(DAY FROM (order_delivered_customer_date - order_purchase_timestamp)))::NUMERIC, 2) AS average_days_to_deliver
FROM orders
WHERE order_status = 'delivered'
GROUP BY delivery_performance
ORDER BY total_orders DESC;

-- TOP 10 stanów z najwyższym odsetkiem spóźnionych dostaw
SELECT c.customer_state,
    ROUND(SUM(CASE 
            WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 1 
            ELSE 0
            END)::numeric / COUNT(*) * 100, 2) AS late_delivery_percentage,
            COUNT(*) AS total_orders
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered' 
    AND o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
HAVING COUNT(*) > 100
ORDER BY late_delivery_percentage DESC
LIMIT 10;