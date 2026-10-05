-- Database: Superstore

-- 20 Business Questions & SQL Queries

-- 1. Add a new corporate client
INSERT INTO customers (customer_id, customer_name, segment)
VALUES ('CORP-99001', 'Apex Global Logistics', 'Corporate')
ON CONFLICT (customer_id) DO NOTHING;

-- 2. Apply a flat promotional discount adjustment to low-selling inventory
UPDATE order_items
SET discount = 0.30
WHERE product_id IN (
    SELECT product_id
    FROM order_items
    GROUP BY product_id
    HAVING SUM(sales) < 50
);

-- 3. Purge voided/orphaned order records
DELETE FROM orders
WHERE order_id NOT IN (
    SELECT DISTINCT order_id FROM order_items
);

-- 4. Categorize transactions by profitability tiers
SELECT 
    row_id,
    order_id,
    sales,
    profit,
    CASE 
        WHEN profit > 100 THEN 'High Margin'
        WHEN profit >= 0 THEN 'Breakeven / Low Margin'
        ELSE 'Loss Making'
    END AS profitability_tier
FROM order_items
ORDER BY profit ASC
LIMIT 10;

-- 5. Top 5 most profitable product categories and sub-categories
SELECT 
    p.category,
    p.sub_category,
    ROUND(SUM(oi.sales), 2) AS total_sales,
    ROUND(SUM(oi.profit), 2) AS total_profit,
    ROUND((SUM(oi.profit) / SUM(oi.sales)) * 100, 2) AS profit_margin_pct
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category, p.sub_category
ORDER BY total_profit DESC
LIMIT 5;

-- 6. Identify regions where average shipping delivery lag exceeds 4 days
SELECT 
    g.region,
    ROUND(AVG(o.ship_date - o.order_date), 2) AS avg_delivery_days,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM orders o
JOIN geography g ON o.geo_id = g.geo_id
GROUP BY g.region
HAVING AVG(o.ship_date - o.order_date) > 4.0
ORDER BY avg_delivery_days DESC;

-- 7. Underperforming sub-categories generating heavy losses
SELECT 
    p.sub_category,
    ROUND(SUM(oi.sales), 2) AS total_revenue,
    ROUND(SUM(oi.profit), 2) AS net_profit
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.sub_category
HAVING SUM(oi.profit) < 0
ORDER BY net_profit ASC;

-- 8. High-value customers generating over $10,000 in sales across at least 5 orders
SELECT 
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.sales), 2) AS lifetime_spend
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(DISTINCT o.order_id) >= 5 AND SUM(oi.sales) > 10000
ORDER BY lifetime_spend DESC;

-- 9. State-level sales and profitability matrix
SELECT 
    g.region,
    g.state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.sales), 2) AS total_sales,
    ROUND(SUM(oi.profit), 2) AS net_profit
FROM geography g
JOIN orders o ON g.geo_id = o.geo_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY g.region, g.state
ORDER BY g.region, total_sales DESC;

-- 10. Shipping mode preferences across customer segments
SELECT 
    c.segment,
    o.ship_mode,
    COUNT(o.order_id) AS order_count,
    ROUND(SUM(oi.sales), 2) AS aggregate_sales
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.segment, o.ship_mode
ORDER BY c.segment, order_count DESC;

-- 11. Cross-sell identification: Top product categories bought together
SELECT 
    p1.category AS category_a,
    p2.category AS category_b,
    COUNT(DISTINCT oi1.order_id) AS co_purchase_count
FROM order_items oi1
JOIN order_items oi2 
    ON oi1.order_id = oi2.order_id 
    AND oi1.product_id < oi2.product_id
JOIN products p1 ON oi1.product_id = p1.product_id
JOIN products p2 ON oi2.product_id = p2.product_id
WHERE p1.category <> p2.category
GROUP BY p1.category, p2.category
ORDER BY co_purchase_count DESC;

-- 12. Top 3 highest-revenue products inside each category (DENSE_RANK)
WITH RankedProducts AS (
    SELECT 
        p.category,
        p.product_name,
        ROUND(SUM(oi.sales), 2) AS revenue,
        DENSE_RANK() OVER (
            PARTITION BY p.category 
            ORDER BY SUM(oi.sales) DESC
        ) AS rnk
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY p.category, p.product_name
)
SELECT category, rnk, product_name, revenue
FROM RankedProducts
WHERE rnk <= 3;

-- 13. Monthly revenue with running cumulative sales (SUM OVER)
WITH MonthlySales AS (
    SELECT 
        DATE_TRUNC('month', o.order_date)::DATE AS sales_month,
        ROUND(SUM(oi.sales), 2) AS monthly_revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY DATE_TRUNC('month', o.order_date)
)
SELECT 
    sales_month,
    monthly_revenue,
    SUM(monthly_revenue) OVER (ORDER BY sales_month) AS cumulative_revenue
FROM MonthlySales
ORDER BY sales_month;

-- 14. Month-over-month (MoM) revenue growth percentage (LAG)
WITH MonthlyRevenue AS (
    SELECT 
        DATE_TRUNC('month', o.order_date)::DATE AS sales_month,
        ROUND(SUM(oi.sales), 2) AS revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY DATE_TRUNC('month', o.order_date)
)
SELECT 
    sales_month,
    revenue,
    LAG(revenue, 1) OVER (ORDER BY sales_month) AS prev_month_revenue,
    ROUND(
        ((revenue - LAG(revenue, 1) OVER (ORDER BY sales_month)) / 
        NULLIF(LAG(revenue, 1) OVER (ORDER BY sales_month), 0)) * 100, 
        2
    ) AS mom_growth_pct
FROM MonthlyRevenue
ORDER BY sales_month;

-- 15. Customer quartile spend distribution (NTILE)
WITH CustomerSpend AS (
    SELECT 
        c.customer_id,
        c.customer_name,
        ROUND(SUM(oi.sales), 2) AS total_spend
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT 
    customer_id,
    customer_name,
    total_spend,
    NTILE(4) OVER (ORDER BY total_spend DESC) AS spend_quartile
FROM CustomerSpend
ORDER BY total_spend DESC;

-- 16. Customer retention: First order date vs. subsequent purchase interval
WITH CustomerFirstOrder AS (
    SELECT 
        customer_id,
        MIN(order_date) AS first_order_date
    FROM orders
    GROUP BY customer_id
),
OrderIntervals AS (
    SELECT 
        o.customer_id,
        o.order_id,
        o.order_date,
        cfo.first_order_date,
        (o.order_date - cfo.first_order_date) AS days_since_first_order
    FROM orders o
    JOIN CustomerFirstOrder cfo ON o.customer_id = cfo.customer_id
    WHERE o.order_date > cfo.first_order_date
)
SELECT 
    customer_id,
    ROUND(AVG(days_since_first_order), 1) AS avg_days_to_repeat_purchase,
    COUNT(order_id) AS repeat_orders_count
FROM OrderIntervals
GROUP BY customer_id
ORDER BY repeat_orders_count DESC
LIMIT 10;

-- 17. Impact of discount thresholds on gross margins
WITH DiscountBuckets AS (
    SELECT 
        CASE 
            WHEN discount = 0 THEN '0% No Discount'
            WHEN discount <= 0.20 THEN '1% - 20% Low'
            WHEN discount <= 0.40 THEN '21% - 40% Moderate'
            ELSE '> 40% Heavy'
        END AS discount_tier,
        sales,
        profit
    FROM order_items
)
SELECT 
    discount_tier,
    COUNT(*) AS total_line_items,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS margin_percentage
FROM DiscountBuckets
GROUP BY discount_tier
ORDER BY total_sales DESC;

-- 18. Pareto Principle (80/20 Rule): Top products contributing to 80% of revenue
WITH ProductSales AS (
    SELECT 
        p.product_name,
        SUM(oi.sales) AS revenue
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY p.product_name
),
RunningSales AS (
    SELECT 
        product_name,
        revenue,
        SUM(revenue) OVER (ORDER BY revenue DESC) AS cumulative_revenue,
        SUM(revenue) OVER () AS overall_total_revenue
    FROM ProductSales
)
SELECT 
    product_name,
    ROUND(revenue, 2) AS product_revenue,
    ROUND((cumulative_revenue / overall_total_revenue) * 100, 2) AS cumulative_pct
FROM RunningSales
WHERE (cumulative_revenue - revenue) / overall_total_revenue < 0.80
ORDER BY product_revenue DESC;

-- 19. Year-over-Year (YoY) segment revenue comparisons
WITH AnnualSegmentSales AS (
    SELECT 
        EXTRACT(YEAR FROM o.order_date) AS order_year,
        c.segment,
        ROUND(SUM(oi.sales), 2) AS revenue
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY EXTRACT(YEAR FROM o.order_date), c.segment
)
SELECT 
    order_year,
    segment,
    revenue,
    LAG(revenue) OVER (PARTITION BY segment ORDER BY order_year) AS prev_year_revenue,
    ROUND(
        ((revenue - LAG(revenue) OVER (PARTITION BY segment ORDER BY order_year)) / 
        NULLIF(LAG(revenue) OVER (PARTITION BY segment ORDER BY order_year), 0)) * 100, 
        2
    ) AS yoy_growth_pct
FROM AnnualSegmentSales
ORDER BY segment, order_year;

-- 20. Cities experiencing high sales volume but negative net margins
WITH CityPerformance AS (
    SELECT 
        g.city,
        g.state,
        ROUND(SUM(oi.sales), 2) AS total_sales,
        ROUND(SUM(oi.profit), 2) AS total_profit,
        COUNT(DISTINCT o.order_id) AS order_count
    FROM orders o
    JOIN geography g ON o.geo_id = g.geo_id
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY g.city, g.state
)
SELECT 
    city,
    state,
    order_count,
    total_sales,
    total_profit
FROM CityPerformance
WHERE total_sales > 5000 AND total_profit < 0
ORDER BY total_profit ASC;
