-- ==========================================
-- ETAP 1: PODSTAWOWA ANALIZA GEOGRAFICZNA
-- ==========================================

-- TOP 10 miast z największą liczbą klientów
SELECT customer_city, COUNT(*) AS total_customers
FROM customers
GROUP BY customer_city
ORDER BY total_customers DESC
LIMIT 10;

-- ==========================================
-- ETAP 2: ANALIZA SPRZEDAŻY I PRODUKTÓW
-- ==========================================

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

-- ==========================================
-- ETAP 3: ANALIZA METOD PŁATNOŚCI
-- ==========================================

-- Podział zamówień według typu płatności
SELECT payment_type,
    COUNT(*) AS total_transactions,
    ROUND(SUM(payment_value)::NUMERIC, 2) AS total_paid_value
FROM order_payments
WHERE payment_type != 'not_defined' AND payment_value > 0
GROUP BY payment_type
ORDER BY total_transactions DESC;
