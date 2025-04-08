CREATE DATABASE RetailMarketing;
USE RetailMarketing;

SELECT* FROM customer_Data3;  
EXEC sp_help 'customer_Data3';
SELECT COUNT(*) AS TotalRows FROM customer_Data3; 

DROP TABLE IF EXISTS customer_Data3;

SELECT* FROM Product_Data3;  
EXEC sp_help 'Product_Data3';
SELECT COUNT(*) AS TotalRows FROM Product_Data3; 

DROP TABLE IF EXISTS Product_Data3;

SELECT* FROM transaction_data3;  
EXEC sp_help 'transaction_data3';
SELECT COUNT(*) AS TotalRows FROM transaction_data3; 

DROP TABLE IF EXISTS transaction_data3;

--------------------------------------------------------------Basic Stats---------------------------------------------------------------------------------------------------

--------------------------------------Customer Data--------------------------------------------
SELECT COLUMN_NAME                   ----(To check column names)-------
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'customer_Data3';
SELECT COUNT(*) AS Total_Customers FROM customer_data3;
SELECT MIN(Cust_Age) AS Min_Age, MAX(Cust_Age) AS Max_Age FROM customer_Data3;
SELECT Cust_Gender, COUNT(*) FROM customer_Data3 GROUP BY Cust_Gender;
SELECT Cust_Gender, COUNT(DISTINCT Cust_ID) AS Customer_Count
FROM customer_Data3
GROUP BY Cust_Gender;


--------------------------------------Product Data----------------------------------------
SELECT COLUMN_NAME                      -----(To check column names)-------
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Product_Data3';
SELECT COUNT(*) AS Total_Products FROM Product_Data3; 
SELECT MIN(Prdct_Amt) AS Min_Amt, MAX(Prdct_Amt) AS Max_Amt, AVG(Prdct_Amt) AS Avg_Amt FROM Product_Data3;
SELECT Prdct_Category, COUNT(*) FROM Product_Data3 GROUP BY Prdct_Category;

-------------------------------------Transaction Data-------------------------------------------------
SELECT COLUMN_NAME                   ----(To check column names)-------
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'transaction_Data3';
SELECT COUNT(*) AS Total_Transactions FROM transaction_Data3;
SELECT MIN(Date) AS First_Tarnsaction, MAX(Date) AS Last_Transaction FROM transaction_Data3;
SELECT Prdct_ID, SUM(Prch_Quantity) AS Total_Quantity_Sold FROM transaction_Data3 GROUP BY Prdct_ID;
SELECT Prdct_ID, COUNT(*) AS Transaction_Count FROM transaction_Data3 GROUP BY Prdct_ID;


---------------------------------------------------------Developing Marketing Data----------------------------------
SELECT t.Prdct_ID, p.Prdct_Category, SUM(t.Prch_Quantity) AS Total_Sales, p.[Prdct_Amt]     -----------Joined Transaction data with Product data to get sales per product---------
FROM transaction_Data3 t
JOIN Product_data3 p ON t.Prdct_ID = p.Prdct_ID
GROUP BY t.Prdct_ID, p.Prdct_Category, p.[Prdct_Amt];


SELECT c.Cust_ID, c.Cust_Gender, COUNT(t.Trnst_ID) AS Total_Sales FROM transaction_Data3 t  -----------Joined Transaction data with Customer data to know sales per customer---------
JOIN customer_Data3 c ON t.Cust_ID = c.Cust_ID
GROUP BY c.Cust_ID, c.Cust_Gender;


SELECT c.Cust_ID, c.Cust_Age, c.Cust_Gender, ------------------------------------Final Merging------------------------------
       SUM(t.Prch_Quantity) AS Total_Products_Bought, 
       COUNT(t.Trnst_ID) AS Total_Transactions, 
       SUM(t.Prch_Quantity * p.[Prdct_Amt]) AS Total_Spending
FROM customer_data3 c
JOIN transaction_data3 t ON c.Cust_ID = t.Cust_ID
JOIN Product_data3 p ON t.Prdct_ID = p.Prdct_ID
GROUP BY c.Cust_ID, c.Cust_Age, c.Cust_Gender;

