-- SQL Script to Clean and Prepare Data for Tableau
-- Author: [Your Name]
-- Date: [Current Date]
-- Description: This script cleans the financial data from the dbo.Financials table,
-- removes unwanted characters, handles negative values, converts data types, 
-- and performs various checks to prepare the data for visualization in Tableau.

-- Remove unwanted characters ($, -, ,) from numeric columns
-- This step ensures that numeric columns are free from non-numeric characters 
-- before conversion to the appropriate data type.

UPDATE dbo.Financials
SET 
    [Gross_Sales] = REPLACE(REPLACE(REPLACE([Gross_Sales], '$', ''), '-', ''), ',', ''),
    Sales = REPLACE(REPLACE(REPLACE(Sales, '$', ''), '-', ''), ',', ''),
    COGS = REPLACE(REPLACE(REPLACE(COGS, '$', ''), '-', ''), ',', ''),
    Profit = REPLACE(REPLACE(REPLACE(Profit, '$', ''), '-', ''), ',', ''),
    Discounts = REPLACE(REPLACE(REPLACE(Discounts, '$', ''), '-', ''), ',', ''),
    [Manufacturing_price] = REPLACE(REPLACE(REPLACE([Manufacturing_price], '$', ''), '-', ''), ',', ''),
    [Sale_price] = REPLACE(REPLACE(REPLACE([Sale_price], '$', ''), '-', ''), ',', ''),
    [Units_Sold] = REPLACE(REPLACE(REPLACE([Units_Sold], '$', ''), '-', ''), ',', '')
WHERE 
    [Gross_Sales] LIKE '%$%' OR [Gross_Sales] LIKE '%-%' OR [Gross_Sales] LIKE '%,' OR
    Sales LIKE '%$%' OR Sales LIKE '%-%' OR Sales LIKE '%,' OR
    COGS LIKE '%$%' OR COGS LIKE '%-%' OR COGS LIKE '%,' OR
    Profit LIKE '%$%' OR Profit LIKE '%-%' OR Profit LIKE '%,' OR
    Discounts LIKE '%$%' OR Discounts LIKE '%-%' OR Discounts LIKE '%,' OR
    [Manufacturing_price] LIKE '%$%' OR [Manufacturing_price] LIKE '%-%' OR [Manufacturing_price] LIKE '%,' OR
    [Sale_price] LIKE '%$%' OR [Sale_price] LIKE '%-%' OR [Sale_price] LIKE '%,' OR
    [Units_Sold] LIKE '%$%' OR [Units_Sold] LIKE '%-%' OR [Units_Sold] LIKE '%,' ;

-- Replace empty cases in the Discounts and Profit columns with '0'
-- This step ensures that empty values are set to '0' for consistency.

UPDATE dbo.Financials
SET Discounts = COALESCE(NULLIF(Discounts, ''), '0'),
    Profit = COALESCE(NULLIF(Profit, ''), '0');

-- Identify and display rows with the value '0' in Profit or Discounts columns
-- Useful for identifying entries where Profit or Discounts might be missing or incorrectly recorded.

SELECT *
FROM dbo.Financials
WHERE Profit = '0' OR Discounts = '0';

-- Find rows with negative values indicated by parentheses
-- This query helps in identifying rows where negative values are represented with parentheses.

SELECT *
FROM dbo.Financials
WHERE [Gross_Sales] LIKE '%(%' OR
      Sales LIKE '%(%' OR
      COGS LIKE '%(%' OR
      Profit LIKE '%(%' OR
      Discounts LIKE '%(%' OR
      [Manufacturing_price] LIKE '%(%' OR
      [Sale_price] LIKE '%(%' OR
      [Units_Sold] LIKE '%(%';

-- Convert negative values indicated by parentheses to actual negative numbers
-- This step ensures that negative values are correctly interpreted and stored.

UPDATE dbo.Financials
SET 
    Profit = CASE 
                 WHEN Profit LIKE '%(%' THEN -CAST(REPLACE(REPLACE(REPLACE(Profit, '(', ''), ')', ''), ',', '') AS FLOAT)
                 ELSE CAST(REPLACE(REPLACE(REPLACE(Profit, '(', ''), ')', ''), ',', '') AS FLOAT)
             END
WHERE 
    Profit LIKE '%(%' OR Profit LIKE '%,' ;

-- Convert all relevant columns to DECIMAL(18, 2) for financial data
-- Ensures proper storage and formatting of financial data.

ALTER TABLE dbo.Financials
ALTER COLUMN [Gross_Sales] DECIMAL(18, 2);

ALTER TABLE dbo.Financials
ALTER COLUMN Sales DECIMAL(18, 2);

ALTER TABLE dbo.Financials
ALTER COLUMN COGS DECIMAL(18, 2);

ALTER TABLE dbo.Financials
ALTER COLUMN Profit DECIMAL(18, 2);

ALTER TABLE dbo.Financials
ALTER COLUMN Discounts DECIMAL(18, 2);

ALTER TABLE dbo.Financials
ALTER COLUMN [Manufacturing_price] DECIMAL(18, 2);

ALTER TABLE dbo.Financials
ALTER COLUMN [Sale_price] DECIMAL(18, 2);

ALTER TABLE dbo.Financials
ALTER COLUMN [Units_Sold] INT;

-- Convert Month_Number and Year to INT
-- Ensures that these columns are in the correct integer format.

ALTER TABLE dbo.Financials
ALTER COLUMN Month_Number INT;

ALTER TABLE dbo.Financials
ALTER COLUMN Year INT;

-- Convert Date column to DATE format for Tableau compatibility
-- Ensures that the Date column is in the correct DATE format.

ALTER TABLE dbo.Financials
ALTER COLUMN [Date] DATE;

-- Display the top 1000 rows for review
-- Provides a quick view of the data to ensure that transformations have been applied correctly.

SELECT TOP (1000) [Segment]
      ,[Country]
      ,[Product]
      ,[Discount_Band]
      ,[Units_Sold]
      ,[Manufacturing_Price]
      ,[Sale_Price]
      ,[Gross_Sales]
      ,[Discounts]
      ,[Sales]
      ,[COGS]
      ,[Profit]
      ,[Date]
      ,[Month_Number]
      ,[Month_Name]
      ,[Year]
  FROM [Finances].[dbo].[Financials]

-- Verify that numeric columns do not contain negative values
-- Useful for ensuring that all numeric columns have valid, non-negative values where applicable.

SELECT 
    SUM(CASE WHEN [Gross_Sales] < 0 THEN 1 ELSE 0 END) AS NegativeGrossSales,
    SUM(CASE WHEN Sales < 0 THEN 1 ELSE 0 END) AS NegativeSales,
    SUM(CASE WHEN COGS < 0 THEN 1 ELSE 0 END) AS NegativeCOGS,
    SUM(CASE WHEN Profit < 0 THEN 1 ELSE 0 END) AS NegativeProfit,
    SUM(CASE WHEN Discounts < 0 THEN 1 ELSE 0 END) AS NegativeDiscounts
FROM dbo.Financials
WHERE [Gross_Sales] IS NOT NULL
  AND Sales IS NOT NULL
  AND COGS IS NOT NULL
  AND Profit IS NOT NULL
  AND Discounts IS NOT NULL;

-- Identify outliers based on certain thresholds
-- Helps in identifying unusually high values that may require further investigation.

SELECT 
    [Segment],
    [Country],
    [Product],
    [Gross_Sales],
    Sales,
    COGS,
    Profit,
    Discounts,
    [Manufacturing_Price],
    [Sale_Price],
    [Units_Sold]
FROM dbo.Financials
WHERE [Gross_Sales] > 1000000 -- Example threshold
   OR Sales > 1000000
   OR COGS > 1000000
   OR Profit > 1000000
   OR Discounts > 1000000;

-- Find all products with Units_Sold having decimal values other than .00
-- Identifies products where Units_Sold has non-integer values which may not be accurate.

SELECT 
    [Product],
    [Units_Sold]
FROM dbo.Financials
WHERE 
    Units_Sold <> CAST(Units_Sold AS INT) AND
    Units_Sold NOT LIKE '%.00';

-- Find duplicate rows based on all columns
-- Identifies duplicate records in the table based on all columns.

SELECT 
    [Segment],
    [Country],
    [Product],
    [Discount_Band],
    [Units_Sold],
    [Manufacturing_Price],
    [Sale_Price],
    [Gross_Sales],
    [Discounts],
    [Sales],
    [COGS],
    [Profit],
    [Date],
    [Month_Number],
    [Month_Name],
    [Year],
    COUNT(*) AS DuplicateCount
FROM dbo.Financials
GROUP BY 
    [Segment],
    [Country],
    [Product],
    [Discount_Band],
    [Units_Sold],
    [Manufacturing_Price],
    [Sale_Price],
    [Gross_Sales],
    [Discounts],
    [Sales],
    [COGS],
    [Profit],
    [Date],
    [Month_Number],
    [Month_Name],
    [Year]
HAVING COUNT(*) > 1;

-- Find missing values in each column
-- Provides a count of missing values for each column to identify columns with incomplete data.

SELECT 
    SUM(CASE WHEN [Segment] IS NULL THEN 1 ELSE 0 END) AS MissingSegment,
    SUM(CASE WHEN [Country] IS NULL THEN 1 ELSE 0 END) AS MissingCountry,
    SUM(CASE WHEN [Product] IS NULL THEN 1 ELSE 0 END) AS MissingProduct,
    SUM(CASE WHEN [Discount_Band] IS NULL THEN 1 ELSE 0 END) AS MissingDiscountBand,
    SUM(CASE WHEN [Units_Sold] IS NULL THEN 1 ELSE 0 END) AS MissingUnitsSold,
    SUM(CASE WHEN [Manufacturing_Price] IS NULL THEN 1 ELSE 0 END) AS MissingManufacturingPrice,
    SUM(CASE WHEN [Sale_Price] IS NULL THEN 1 ELSE 0 END) AS MissingSalePrice,
    SUM(CASE WHEN [Gross_Sales] IS NULL THEN 1 ELSE 0 END) AS MissingGrossSales,
    SUM(CASE WHEN [Discounts] IS NULL THEN 1 ELSE 0 END) AS MissingDiscounts,
    SUM(CASE WHEN [Sales] IS NULL THEN 1 ELSE 0 END) AS MissingSales,
    SUM(CASE WHEN [COGS] IS NULL THEN 1 ELSE 0 END) AS MissingCOGS,
    SUM(CASE WHEN [Profit] IS NULL THEN 1 ELSE 0 END) AS MissingProfit,
    SUM(CASE WHEN [Date] IS NULL THEN 1 ELSE 0 END) AS MissingDate,
    SUM(CASE WHEN [Month_Number] IS NULL THEN 1 ELSE 0 END) AS MissingMonthNumber,
    SUM(CASE WHEN [Month_Name] IS NULL THEN 1 ELSE 0 END) AS MissingMonthName,
    SUM(CASE WHEN [Year] IS NULL THEN 1 ELSE 0 END) AS MissingYear
FROM dbo.Financials;

-- Segment Performance: Total sales, profit, and average units sold by segment
SELECT 
    Segment, 
    SUM(Sales) AS Total_Sales, 
    SUM(Profit) AS Total_Profit, 
    AVG(Units_Sold) AS Avg_Units_Sold
FROM 
    dbo.Financials
GROUP BY 
    Segment;

-- Segment Growth: Total sales and profit by segment and year
SELECT 
    Segment, 
    Year, 
    SUM(Sales) AS Total_Sales, 
    SUM(Profit) AS Total_Profit
FROM 
    dbo.Financials
GROUP BY 
    Segment, Year
ORDER BY 
    Segment, Year;

-- Segment Contribution: Sales and profit contribution percentage by segment
SELECT 
    Segment, 
    SUM(Sales) * 100.0 / (SELECT SUM(Sales) FROM dbo.Financials) AS Sales_Contribution, 
    SUM(Profit) * 100.0 / (SELECT SUM(Profit) FROM dbo.Financials) AS Profit_Contribution
FROM 
    dbo.Financials
GROUP BY 
    Segment;

-- Country Analysis: Total sales and profit by country
SELECT 
    Country, 
    SUM(Sales) AS Total_Sales, 
    SUM(Profit) AS Total_Profit
FROM 
    dbo.Financials
GROUP BY 
    Country;

-- Country Growth Rates: Total sales and profit by country and year
SELECT 
    Country, 
    Year, 
    SUM(Sales) AS Total_Sales, 
    SUM(Profit) AS Total_Profit
FROM 
    dbo.Financials
GROUP BY 
    Country, Year
ORDER BY 
    Country, Year;

-- Country Market Share: Sales and profit contribution percentage by country
SELECT 
    Country, 
    SUM(Sales) * 100.0 / (SELECT SUM(Sales) FROM dbo.Financials) AS Sales_Market_Share, 
    SUM(Profit) * 100.0 / (SELECT SUM(Profit) FROM dbo.Financials) AS Profit_Market_Share
FROM 
    dbo.Financials
GROUP BY 
    Country;

-- Product Performance: Total sales and profit by product
SELECT 
    Product, 
    SUM(Sales) AS Total_Sales, 
    SUM(Profit) AS Total_Profit
FROM 
    dbo.Financials
GROUP BY 
    Product;

-- Product Trends: Total sales and profit by product and year
SELECT 
    Product, 
    Year, 
    SUM(Sales) AS Total_Sales, 
    SUM(Profit) AS Total_Profit
FROM 
    dbo.Financials
GROUP BY 
    Product, Year
ORDER BY 
    Product, Year;

-- Top Products: Top 10 products by sales and profit
SELECT 
    Product, 
    SUM(Sales) AS Total_Sales, 
    SUM(Profit) AS Total_Profit
FROM 
    dbo.Financials
GROUP BY 
    Product
ORDER BY 
    Total_Sales DESC, Total_Profit DESC
LIMIT 10;

-- Discount Band Analysis: Total sales and profit by discount band
SELECT 
    Discount_Band, 
    SUM(Sales) AS Total_Sales, 
    SUM(Profit) AS Total_Profit
FROM 
    dbo.Financials
GROUP BY 
    Discount_Band;

-- Discount Utilization: Frequency and total discounts applied by discount band
SELECT 
    Discount_Band, 
    COUNT(*) AS Discount_Usage, 
    SUM(Discounts) AS Total_Discounts
FROM 
    dbo.Financials
GROUP BY 
    Discount_Band;

-- Units Sold: Total units sold per year
SELECT 
    Year, 
    SUM(Units_Sold) AS Total_Units_Sold
FROM 
    dbo.Financials
GROUP BY 
    Year
ORDER BY 
    Year;

-- Units Sold by Product: Total units sold by product
SELECT 
    Product, 
    SUM(Units_Sold) AS Total_Units_Sold
FROM 
    dbo.Financials
GROUP BY 
    Product
ORDER BY 
    Total_Units_Sold DESC;

-- Units Sold by Country: Total units sold by country
SELECT 
    Country, 
    SUM(Units_Sold) AS Total_Units_Sold
FROM 
    dbo.Financials
GROUP BY 
    Country;

-- Manufacturing Price Analysis: Average manufacturing price and total profit by product
SELECT 
    Product, 
    AVG(Manufacturing_Price) AS Avg_Manufacturing_Price, 
    SUM(Profit) AS Total_Profit
FROM 
    dbo.Financials
GROUP BY 
    Product;

-- Manufacturing Price by Country: Average manufacturing price by product and country
SELECT 
    Product, 
    Country, 
    AVG(Manufacturing_Price) AS Avg_Manufacturing_Price
FROM 
    dbo.Financials
GROUP BY 
    Product, Country;

-- Sale Price Analysis: Total sales and profit by sale price
SELECT 
    Sale_Price, 
    SUM(Sales) AS Total_Sales, 
    SUM(Profit) AS Total_Profit
FROM 
    dbo.Financials
GROUP BY 
    Sale_Price;

-- Sale Price Trends: Average sale price per year
SELECT 
    Year, 
    AVG(Sale_Price) AS Avg_Sale_Price
FROM 
    dbo.Financials
GROUP BY 
    Year;

-- Gross Sales: Total gross sales per year
SELECT 
    Year, 
    SUM(Gross_Sales) AS Total_Gross_Sales
FROM 
    dbo.Financials
GROUP BY 
    Year;

-- Gross Sales by Product/Country: Total gross sales by product and country
SELECT 
    Product, 
    Country, 
    SUM(Gross_Sales) AS Total_Gross_Sales
FROM 
    dbo.Financials
GROUP BY 
    Product, Country;

-- Discounts Impact: Total discounts, sales, and profit
SELECT 
    SUM(Discounts) AS Total_Discounts, 
    SUM(Sales) AS Total_Sales, 
    SUM(Profit) AS Total_Profit
FROM 
    dbo.Financials;

-- Discounts Trends: Total discounts per year
SELECT 
    Year, 
    SUM(Discounts) AS Total_Discounts
FROM 
    dbo.Financials
GROUP BY 
    Year;

-- Sales Performance by Product/Country: Total sales by product and country
SELECT 
    Product, 
    Country, 
    SUM(Sales) AS Total_Sales
FROM 
    dbo.Financials
GROUP BY 
    Product, Country;

-- Sales Trends: Total sales per year
SELECT 
    Year, 
    SUM(Sales) AS Total_Sales
FROM 
    dbo.Financials
GROUP BY 
    Year;

-- COGS by Product/Country: Total cost of goods sold by product and country
SELECT 
    Product, 
    Country, 
    SUM(COGS) AS Total_COGS
FROM 
    dbo.Financials
GROUP BY 
    Product, Country;

-- Profit by Product/Country: Total profit by product and country
SELECT 
    Product, 
    Country, 
    SUM(Profit) AS Total_Profit
FROM 
    dbo.Financials
GROUP BY 
    Product, Country;

-- Profit Trends: Total profit per year
SELECT 
    Year, 
    SUM(Profit) AS Total_Profit
FROM 
    dbo.Financials
GROUP BY 
    Year;