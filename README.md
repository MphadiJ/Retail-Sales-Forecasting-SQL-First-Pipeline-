🛒 Retail Sales Intelligence & Forecasting Pipeline (SQL-Driven)
🚀 Executive Summary

This project builds an end-to-end retail analytics pipeline using SQL, transforming raw transactional and store-level data into a structured dataset suitable for predictive modeling and business decision-making.

The objective is to identify key drivers of store sales performance, including:

-Promotions
-Store type & assortment
-Seasonality
-Customer behavior
-Competition effects

This mirrors real-world retail forecasting problems faced by chains such as Rossmann-style store networks.

🎯 Business Problem

Retail organizations struggle with:

Unpredictable daily sales fluctuations
Inefficient promotion strategies
Lack of visibility into store-level performance drivers
Weak understanding of competition impact
📌 Goal:

Build a data pipeline that explains and prepares data for forecasting store sales, enabling:

Revenue optimization
Smarter promotion planning
Store performance benchmarking
🧱 Project Architecture
project-root/
│
├── data/                  # Raw CSV inputs
│
├── sql/
│   ├── schema.sql         # Database structure & indexing
│   ├── EDA.sql            # Exploratory analysis
│   ├── feature_engineering.sql
│   └── modeling_prep.sql  # ML-ready dataset
│
└── README.md
⚙️ Tech Stack
SQL (SQLite engine)
Window Functions (LAG, rolling averages)
CTE-based transformations
Analytical aggregations

⚠️ Note: SQLite limitations handled (no DATE_TRUNC, no SELECT INTO)

🔄 Data Pipeline Overview
1. Schema Design & Data Loading
Defined normalized schema for train and store
Indexed key fields (storeid, date) for performance
2. Exploratory Data Analysis (EDA)

Key analyses performed:

Data completeness & quality checks
Sales distribution & seasonality
Promotion effectiveness
Store-type performance benchmarking
Competition impact assessment
3. Feature Engineering

Advanced time-series and behavioral features:

📅 Temporal Features
Year
Month
Week of year
Weekend indicator
🔁 Time-Series Features
Sales lag (1-day, 7-day)
7-day rolling average
🏪 Store Intelligence Features
Store type encoding
Assortment segmentation
Competition distance impact
4. Model-Ready Dataset Construction

Final dataset includes:

Cleaned transactional data
Imputed missing values
Encoded categorical variables
Engineered predictive features

Output table:

model_dataset
📊 Key Business Insights
📈 1. Promotions Drive Revenue Uplift

Stores with active promotions consistently show significant sales increases, confirming strong promotional elasticity.

🏪 2. Store Type is a Strong Performance Driver

Certain store types outperform others, suggesting:

Structural differences in customer base
Location-driven demand variation
📉 3. Competition Reduces Revenue

Stores located near competitors exhibit lower average sales, highlighting spatial market pressure.

📅 4. Strong Seasonality Effects

Sales vary significantly across:

Months
Weeks
Weekdays vs weekends

This supports demand forecasting and inventory optimization.

👥 5. Customer Efficiency Varies Across Stores

Revenue per customer differs widely, indicating:

Pricing power differences
Upselling effectiveness variation
🧠 Skills Demonstrated
Advanced SQL (CTEs, window functions, joins)
Time-series feature engineering
Data cleaning & imputation strategies
Business-driven analytical thinking
Retail domain understanding
End-to-end pipeline design
📦 Output Tables
Table	Description
train	Raw sales transactions
store	Store metadata
feature_table	Engineered features
model_dataset	ML-ready dataset
