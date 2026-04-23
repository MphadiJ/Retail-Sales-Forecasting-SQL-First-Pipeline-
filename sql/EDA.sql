/*
 Exploratory Data Analysis for store + train tables
*/

-- DATA OVERVIEW
-- 

-- Row counts
SELECT 'train' AS table_name, COUNT(*) AS total_rows FROM train
UNION ALL
SELECT 'store', COUNT(*) FROM store;

-- Preview data
SELECT * FROM train LIMIT 10;
SELECT * FROM store LIMIT 10;

-- DATA QUALITY CHECKS
-- Missing values (train)
SELECT
    SUM(CASE WHEN storeid IS NULL THEN 1 ELSE 0 END) AS storeid_nulls,
    SUM(CASE WHEN sales IS NULL THEN 1 ELSE 0 END) AS sales_nulls,
    SUM(CASE WHEN customers IS NULL THEN 1 ELSE 0 END) AS customers_nulls
FROM train;

-- Missing values (store)
SELECT
    SUM(CASE WHEN storetype IS NULL THEN 1 ELSE 0 END) AS storetype_nulls,
    SUM(CASE WHEN assortment IS NULL THEN 1 ELSE 0 END) AS assortment_nulls,
    SUM(CASE WHEN competitiondistance IS NULL THEN 1 ELSE 0 END) AS comp_distance_nulls
FROM store;

-- Duplicate check (train)
SELECT storeid, date, COUNT(*) AS duplicate_count
FROM train
GROUP BY storeid, date
HAVING COUNT(*) > 1;


--JOIN DATASET

-- Create unified dataset for analysis
WITH joined_data AS (
    SELECT 
        t.*,
        s.storetype,
        s.assortment,
        s.competitiondistance,
        s.promo2
    FROM train t
    LEFT JOIN store s
        ON t.storeid = s.storeid
)

SELECT * FROM joined_data LIMIT 10;

--BASIC SALES METRICS
-- Total sales & customers
SELECT
    SUM(sales) AS total_sales,
    SUM(customers) AS total_customers,
    AVG(sales) AS avg_sales_per_day
FROM train;

-- Sales per store
SELECT
    storeid,
    SUM(sales) AS total_sales
FROM train
GROUP BY storeid
ORDER BY total_sales DESC;

-- TEMPORAL ANALYSIS

-- Sales trend over time
SELECT
    strftime('month', date) AS month,
    SUM(sales) AS monthly_sales
FROM train
GROUP BY month
ORDER BY month;

-- Day of week performance
SELECT
    dayofweek,
    AVG(sales) AS avg_sales
FROM train
GROUP BY dayofweek
ORDER BY dayofweek;

--PROMOTION IMPACT

-- Compare sales with and without promo
SELECT
    promo,
    AVG(sales) AS avg_sales
FROM train
GROUP BY promo;

-- Promo effectiveness by store type
WITH joined_data AS (
    SELECT 
        t.sales,
        t.promo,
        s.storetype
    FROM train t
    LEFT JOIN store s
        ON t.storeid = s.storeid
)

SELECT
    storetype,
    promo,
    AVG(sales) AS avg_sales
FROM joined_data
GROUP BY storetype, promo
ORDER BY storetype;

-- STORE CHARACTERISTICS IMPACT

-- Sales by store type
SELECT
    s.storetype,
    AVG(t.sales) AS avg_sales
FROM train t
LEFT JOIN store s
    ON t.storeid = s.storeid
GROUP BY s.storetype;

-- Sales by assortment
SELECT
    s.assortment,
    AVG(t.sales) AS avg_sales
FROM train t
LEFT JOIN store s
    ON t.storeid = s.storeid
GROUP BY s.assortment;

-- COMPETITION ANALYSIS

-- Impact of competition distance
SELECT
    CASE 
        WHEN competitiondistance < 500 THEN 'Very Close'
        WHEN competitiondistance < 2000 THEN 'Moderate'
        ELSE 'Far'
    END AS competition_bucket,
    AVG(t.sales) AS avg_sales
FROM train t
LEFT JOIN store s
    ON t.storeid = s.storeid
GROUP BY competition_bucket
ORDER BY avg_sales DESC;

-- HOLIDAY IMPACT

-- State holiday effect
SELECT
    stateholiday,
    AVG(sales) AS avg_sales
FROM train
GROUP BY stateholiday;

-- School holiday effect
SELECT
    schoolholiday,
    AVG(sales) AS avg_sales
FROM train
GROUP BY schoolholiday;

--CUSTOMER BEHAVIOR

-- Sales per customer (efficiency metric)
SELECT
    storeid,
    AVG(sales / NULLIF(customers, 0)) AS revenue_per_customer
FROM train
GROUP BY storeid
ORDER BY revenue_per_customer DESC;

-- 11. OUTLIER DETECTION

-- Identify unusually high sales
SELECT *
FROM train
WHERE sales > (
    SELECT AVG(sales) + 3 * STDDEV(sales)
    FROM train
);

