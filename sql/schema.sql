/*
schema.sql
Defines raw tables and loads data
*/

-- Drop tables if exist
DROP TABLE IF EXISTS train;
DROP TABLE IF EXISTS store;

-- Create store table
CREATE TABLE store (
    storeid INT PRIMARY KEY,
    storetype VARCHAR(10),
    assortment VARCHAR(10),
    competitiondistance FLOAT,
    competitionopensincemonth INT,
    competitionopensinceyear INT,
    promo2 INT,
    promo2sinceweek INT,
    promo2sinceyear INT,
    promointerval VARCHAR(50)
);

-- Create train table
CREATE TABLE train (
    storeid INT,
    dayofweek INT,
    date DATE,
    sales FLOAT,
    customers INT,
    open INT,
    promo INT,
    stateholiday VARCHAR(5),
    schoolholiday INT
);

