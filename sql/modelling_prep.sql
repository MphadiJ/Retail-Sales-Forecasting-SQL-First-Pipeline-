-- Drop existing table
DROP TABLE IF EXISTS model_dataset;

-- Create model-ready dataset
CREATE TABLE model_dataset AS

WITH cleaned AS (
    SELECT *
    FROM feature_table
    WHERE open = 1
      AND sales > 0
),

-- Handle missing values
imputed AS (
    SELECT *,
        -- Global average competition distance
        COALESCE(
            competitiondistance,
            (SELECT AVG(competitiondistance) FROM feature_table)
        ) AS comp_distance_filled,

        COALESCE(sales_lag_1, 0) AS sales_lag_1_filled,
        COALESCE(sales_lag_7, 0) AS sales_lag_7_filled
    FROM cleaned
),

-- Encode categorical variables
encoded AS (
    SELECT *,
        CASE WHEN storetype = 'a' THEN 1 ELSE 0 END AS storetype_a,
        CASE WHEN storetype = 'b' THEN 1 ELSE 0 END AS storetype_b,
        CASE WHEN storetype = 'c' THEN 1 ELSE 0 END AS storetype_c
    FROM imputed
)

-- Final dataset
SELECT
    storeid,
    date,
    sales,
    customers,
    promo,
    schoolholiday,
    comp_distance_filled,
    sales_lag_1_filled,
    sales_lag_7_filled,
    rolling_avg_7,
    storetype_a,
    storetype_b,
    storetype_c
FROM encoded;