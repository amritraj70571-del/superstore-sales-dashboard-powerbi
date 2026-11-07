-- SuperStore Sales Dashboard: SQL Analysis
-- Database: MySQL 8.0+
-- Source: SuperStore_Sales_Dataset.csv (5,901 rows)
--
-- Import the CSV into a table named `superstore_sales`.
-- Use the original column names, or map them to the names below.
-- This script assumes the original column names are retained.
-- Order Date and Ship Date should be imported as DATE values.

-- 1. Overall business KPIs
SELECT
    COUNT(DISTINCT `Order ID`) AS total_orders,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit,
    SUM(Quantity) AS total_quantity,
    ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0) * 100, 2) AS profit_margin_pct
FROM superstore_sales;

-- 2. Sales and profit by region
SELECT
    Region,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore_sales
GROUP BY Region
ORDER BY total_sales DESC;

-- 3. Top 10 states by sales
SELECT
    State,
    ROUND(SUM(Sales), 2) AS total_sales
FROM superstore_sales
GROUP BY State
ORDER BY total_sales DESC
LIMIT 10;

-- 4. Sales by category and sub-category
SELECT
    Category,
    `Sub-Category`,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore_sales
GROUP BY Category, `Sub-Category`
ORDER BY total_sales DESC;

-- 5. Monthly sales trend
SELECT
    YEAR(`Order Date`) AS sales_year,
    MONTH(`Order Date`) AS sales_month,
    ROUND(SUM(Sales), 2) AS monthly_sales
FROM superstore_sales
GROUP BY YEAR(`Order Date`), MONTH(`Order Date`)
ORDER BY sales_year, sales_month;

-- 6. Top 10 customers by revenue
SELECT
    `Customer ID`,
    `Customer Name`,
    ROUND(SUM(Sales), 2) AS total_sales
FROM superstore_sales
GROUP BY `Customer ID`, `Customer Name`
ORDER BY total_sales DESC
LIMIT 10;

-- 7. Products ranked by sales (window function)
SELECT
    `Product Name`,
    ROUND(SUM(Sales), 2) AS total_sales,
    DENSE_RANK() OVER (ORDER BY SUM(Sales) DESC) AS sales_rank
FROM superstore_sales
GROUP BY `Product Name`;

-- 8. Profit / loss classification using CASE
SELECT
    `Sub-Category`,
    ROUND(SUM(Profit), 2) AS total_profit,
    CASE
        WHEN SUM(Profit) > 0 THEN 'Profitable'
        WHEN SUM(Profit) < 0 THEN 'Loss'
        ELSE 'Break-even'
    END AS performance_status
FROM superstore_sales
GROUP BY `Sub-Category`
ORDER BY total_profit DESC;

-- 9. Average shipping time by ship mode
SELECT
    `Ship Mode`,
    ROUND(AVG(DATEDIFF(`Ship Date`, `Order Date`)), 2) AS avg_shipping_days
FROM superstore_sales
GROUP BY `Ship Mode`
ORDER BY avg_shipping_days;

-- 10. CTE: monthly sales with previous month's sales
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(`Order Date`, '%Y-%m') AS sales_month,
        SUM(Sales) AS total_sales
    FROM superstore_sales
    GROUP BY DATE_FORMAT(`Order Date`, '%Y-%m')
)
SELECT
    sales_month,
    ROUND(total_sales, 2) AS total_sales,
    ROUND(
        LAG(total_sales) OVER (ORDER BY sales_month),
        2
    ) AS previous_month_sales
FROM monthly_sales
ORDER BY sales_month;

-- 11. Identify loss-making products
SELECT
    `Product Name`,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore_sales
GROUP BY `Product Name`
HAVING SUM(Profit) < 0
ORDER BY total_profit ASC;

-- 12. Sales by customer segment and payment mode
SELECT
    Segment,
    `Payment Mode`,
    COUNT(DISTINCT `Order ID`) AS total_orders,
    ROUND(SUM(Sales), 2) AS total_sales
FROM superstore_sales
GROUP BY Segment, `Payment Mode`
ORDER BY Segment, total_sales DESC;
