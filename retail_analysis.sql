
-- Create table
CREATE TABLE RetailSales (
    OrderID VARCHAR(20),
    OrderDate DATE,
    Category VARCHAR(50),
    SubCategory VARCHAR(50),
    Region VARCHAR(50),
    Sales DECIMAL(10,2),
    Quantity INT,
    Discount DECIMAL(5,2),
    Profit DECIMAL(10,2)
);

-- 1. Remove duplicates (check first)
SELECT OrderID, COUNT(*)
FROM RetailSales
GROUP BY OrderID
HAVING COUNT(*) > 1;

-- 2. Profitability by Category
SELECT Category, 
       SUM(Sales) AS TotalSales,
       SUM(Profit) AS TotalProfit,
       AVG(Profit / Sales) AS AvgProfitMargin
FROM RetailSales
GROUP BY Category
ORDER BY TotalProfit DESC;

-- 3. Profitability by Sub-Category (Top 10)
SELECT Category, SubCategory,
       SUM(Sales) AS TotalSales,
       SUM(Profit) AS TotalProfit
FROM RetailSales
GROUP BY Category, SubCategory
ORDER BY TotalProfit DESC
LIMIT 10;

-- 4. Regional Analysis
SELECT Region,
       SUM(Sales) AS TotalSales,
       SUM(Profit) AS TotalProfit,
       COUNT(OrderID) AS Orders
FROM RetailSales
GROUP BY Region
ORDER BY TotalProfit DESC;

-- 5. Monthly Sales & Profit Trend
SELECT DATE_FORMAT(OrderDate, '%Y-%m') AS YearMonth,
       SUM(Sales) AS MonthlySales,
       SUM(Profit) AS MonthlyProfit
FROM RetailSales
GROUP BY YearMonth
ORDER BY YearMonth;

-- 6. Identify Low-Margin Sub-Categories
SELECT SubCategory, 
       SUM(Sales) AS TotalSales,
       SUM(Profit) AS TotalProfit,
       (SUM(Profit)/SUM(Sales)) AS ProfitMargin
FROM RetailSales
GROUP BY SubCategory
HAVING ProfitMargin < 0.15
ORDER BY ProfitMargin ASC;
