USE RetailSalesDB;
GO

SELECT TOP 10 *
FROM SalesData;

-- Total Orders

SELECT COUNT(DISTINCT Order_ID) AS Total_Orders
FROM SalesData;

-- Total product Sold

SELECT SUM(Quantity) AS Total_Quantity_Sold
FROM SalesData;

-- Total Sales

SELECT SUM(Sales) AS TotalSales
FROM SalesData;

-- Total Profit

SELECT SUM(Profit) AS TotalProfit
FROM SalesData;

-- Sales by Region

SELECT Region,
       SUM(Sales) AS TotalSales
FROM SalesData
GROUP BY Region
ORDER BY TotalSales DESC;

-- Top 10 Products

SELECT TOP 10
Product_Name,
SUM(Sales) AS Revenue
FROM SalesData
GROUP BY Product_Name
ORDER BY Revenue DESC;

-- Loss Making Products

SELECT
Product_Name,
SUM(Profit) AS Total_Profit
FROM SalesData
GROUP BY Product_Name
HAVING SUM(Profit) < 0
ORDER BY Total_Profit;

-- Monthly Sales Trend

SELECT
YEAR(Order_Date) AS Year,
MONTH(Order_Date) AS Month,
SUM(Sales) AS Revenue
FROM SalesData
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY Year, Month;

-- Percentage of Sales by Category

SELECT
    Category,
    SUM(Sales) AS Total_Sales,
    CONCAT(
        ROUND(
            SUM(Sales) * 100.0 /
            (SELECT SUM(Sales)
             FROM SalesData),
            2
        ),
        '%'
    ) AS Sales_Percentage
FROM SalesData
GROUP BY Category
ORDER BY SUM(Sales) DESC;

SELECT
    Region,
    SUM(Sales) AS Total_Sales,
    CONCAT(
        ROUND(
            SUM(Sales) * 100.0 /
            (SELECT SUM(Sales)
             FROM SalesData),
            2
        ),
        '%'
    ) AS Sales_Percentage
FROM SalesData
GROUP BY Region
ORDER BY SUM(Sales) DESC;

-- Top Customers

SELECT TOP 10
Customer_Name,
SUM(Sales) AS Revenue
FROM Sales
GROUP BY Customer_Name
ORDER BY Revenue DESC;

-- Rank Products by Sales

SELECT
Product_Name,
SUM(Sales) AS Revenue,
RANK() OVER(ORDER BY SUM(Sales) DESC) AS Product_Rank
FROM SalesData
GROUP BY Product_Name;

-- Average Order Value (AOV)

SELECT
    SUM(Sales) AS Total_Sales,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    SUM(Sales) / COUNT(DISTINCT Order_ID) AS Average_Order_Value
FROM SalesData;

-- Repeat Customers

SELECT COUNT(*) AS Repeat_Customers
FROM (
    SELECT Customer_ID
    FROM SalesData
    GROUP BY Customer_ID
    HAVING COUNT(DISTINCT Order_ID) > 1
) AS RepeatCustomers;

-- City-wise Sales and Orders

SELECT
    City,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM SalesData
GROUP BY City
ORDER BY Total_Sales DESC;

-- Category-wise Performance

SELECT
    Category,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM SalesData
GROUP BY Category
ORDER BY Total_Sales DESC;

-- Profit Margin by Category

SELECT
    Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND((SUM(Profit) * 100.0 / SUM(Sales)), 2) AS Profit_Margin_Percentage
FROM SalesData
GROUP BY Category
ORDER BY Profit_Margin_Percentage DESC;

