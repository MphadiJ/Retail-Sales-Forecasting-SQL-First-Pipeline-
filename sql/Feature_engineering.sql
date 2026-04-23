

-- Drop if exists (SQLite uses CREATE TABLE AS, not SELECT INTO)
DROP TABLE IF EXISTS feature_table;

-- Create feature table
CREATE TABLE feature_table AS

WITH base AS (
    SELECT 
        t.*,
        s.storetype,
        s.assortment,
        s.competitiondistance,
        s.promo2
    FROM train t
    LEFT JOIN store s
        ON t.storeid = s.storeid
),

-- Date features (SQLite uses strftime)
date_features AS (
    SELECT *,
        CAST(strftime('%Y', date) AS INTEGER) AS year,
        CAST(strftime('%m', date) AS INTEGER) AS month,
        CAST(strftime('%W', date) AS INTEGER) AS weekofyear,
        CASE 
            WHEN dayofweek IN (6,7) THEN 1 ELSE 0 
        END AS is_weekend
    FROM base
),

-- Lag features (SQLite supports window functions if version >= 3.25)
lag_features AS (
    SELECT *,
        LAG(sales, 1) OVER (PARTITION BY storeid ORDER BY date) AS sales_lag_1,
        LAG(sales, 7) OVER (PARTITION BY storeid ORDER BY date) AS sales_lag_7
    FROM date_features
),

-- Rolling average
rolling_features AS (
    SELECT *,
        AVG(sales) OVER (
            PARTITION BY storeid
            ORDER BY date
            ROWS BETWEEN 7 PRECEDING AND CURRENT ROW
        ) AS rolling_avg_7
    FROM lag_features
)

SELECT * FROM rolling_features;