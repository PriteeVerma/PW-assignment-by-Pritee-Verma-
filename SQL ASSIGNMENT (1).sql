#Question 1 : Explain the fundamental differences between DDL, DML, and DQL 
#Commands in SQL. Provide one example for each type of command. 

#ANS : DDL (Data Definition Language) : DDL commands are responsible for defining, modifying, and managing database structure (schema objects). They operate at the metadata level.
# Example :CREATE, TRUNCATE, DROP
#DML (Data Manipulation Language) : DML commands handle manipulation of actual data stored inside tables.
# Example : INSERT
# DQL (Data Query Language) : DQL is focused purely on querying and retrieving data from the database without modifying it.
# Example : SELECT

# Q2. #Question 2 : What is the purpose of SQL constraints? Name and describe three common types 
#of constraints, providing a simple scenario where each would be useful. 

# ANS : SQL constraints are rules applied to table columns to control what type of data can be stored.
# Their main purpose is to keep data correct, safe, and organized.
#(1) - PRIMARY KEY : It uniquely identifies each row in a table.
#It cannot be duplicate and cannot be NULL.
#Example Scenario:
#In a Students table, each student has a unique student_id.
#(2) - FOREIGN KEY : It connects two tables.
# It ensures the value must already exist in another table.
#Example Scenario:
#An Orders table has customer_id, student_id, email_id
#That customer must already exist in the Customers table.
#(3) - NOT NULL : It does not allow empty values.
#Example Scenario:
#Every employee must have a name, which cannot be a null value

# #Question 3 :  Explain the difference between LIMIT and OFFSET clauses in SQL. How 
#would you use them together to retrieve the third page of results, assuming each page 
#has 10 records? 

#Ans: LIMIT Clause
#Defines the maximum number of rows returned by a query.
#It restricts the size of the result set.
#Used to control how much data is displayed or processed.
#OFFSET Clause
#Specifies the number of rows to skip before starting to return rows.
#It shifts the starting point of the result set.
#Commonly used for pagination.
#Using Them Together for Pagination
#If each page contains 10 records, and you want the third page:
#Page size = 10
#Page number = 3
#OFFSET = (3 − 1) × 10 = 20
#LIMIT = 10
#Conceptually:
#Skip the first 20 records
#Retrieve the next 10 records

#Question 4 : What is a Common Table Expression (CTE) in SQL, and what are its main 
#benefits? Provide a simple SQL example demonstrating its usage.

# Ans : A Common Table Expression (CTE) is a temporary result set in SQL.
#It is created using the WITH keyword and works like a temporary table that you can use inside a query.
#It exists only while the query is running. 
#Why We Use CTE (Main Benefits)
#Makes query easy to read – Breaks complex queries into small parts.
#Reduces repetition – No need to write the same subquery again and again.
#Easy to manage – Helps organize logic clearly.
#Supports recursion – Useful for hierarchical data like employee-manager structure.

# Q5 #Question 5 : Describe the concept of SQL Normalization and its primary goals. Briefly 
#explain the first three normal forms (1NF, 2NF, 3NF). 

#Ans : SQL Normalization is a systematic database design methodology used to organize data in relational databases to reduce redundancy and improve data integrity.
#It is a rule-based framework that restructures tables into smaller, well-defined entities while preserving relationships using primary and foreign keys.
#Primary Goals of Normalization
#(1) - Eliminate Data Redundancy
#Avoid storing the same data in multiple places.
#(2) - Ensure Data Integrity & Consistency
#Reduce update, insert, and delete anomalies.
#(3) - Improve Query Efficiency (Long-Term Scalability)
#Structured schema design supports optimized performance.
#(4) - Enhance Maintainability
#Clean schema = easier debugging and scaling.
#1NF (First Normal Form)
#Rule:
#Each column should have only one value (no multiple values in one cell).
#Each row should be unique.
#1NF (First Normal Form)
#2NF (Second Normal Form)
#Rule:
#Must be in 1NF.
#Every column should depend on the whole primary key.
#This mostly applies when there is a composite key
#3NF (Third Normal Form)
#Rule:
#Must be in 2NF.
#No column should depend on another non-key column.

# Q6. Create a database EcommerceDB and perform the tasks
create database ECommerceDB;
use EcommerceDB;
# CATEGORIES TABLE
create table Categories(
CategoryID INT PRIMARY KEY,
CategoryName Varchar(50) NOT NULL UNIQUE);

# PRODUCTS TABLE
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL UNIQUE,
    CategoryID INT,
    Price DECIMAL(10,2) NOT NULL,
    StockQuantity INT,
    
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);
# CUSTOMERS TABLE
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    JoinDate DATE
);
# ORDERS TABLE
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2),
    
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Categories (CategoryID, CategoryName)
VALUES 
(1, 'Electronics'),
(2, 'Books'),
(3, 'Home Goods'),
(4, 'Apparel');

INSERT INTO Products (ProductID, ProductName, CategoryID, Price, StockQuantity)
VALUES
(101, 'Laptop Pro', 1, 1200.00, 50),
(102, 'SQL Handbook', 2, 45.50, 200),
(103, 'Smart Speaker', 1, 99.99, 150),
(104, 'Coffee Maker', 3, 75.00, 80),
(105, 'Novel: The Great SQL', 2, 25.00, 120),
(106, 'Wireless Earbuds', 1, 150.00, 100),
(107, 'Blender X', 3, 120.00, 60),
(108, 'T-Shirt Casual', 4, 20.00, 300);

INSERT INTO Customers (CustomerID, CustomerName, Email, JoinDate)
VALUES
(1, 'Alice Wonderland', 'alice@example.com', '2023-01-10'),
(2, 'Bob the Builder', 'bob@example.com', '2022-11-25'),
(3, 'Charlie Chaplin', 'charlie@example.com', '2023-03-01'),
(4, 'Diana Prince', 'diana@example.com', '2021-04-26');

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES
(1001, 1, '2023-04-26', 1245.50),
(1002, 2, '2023-10-12', 99.99),
(1003, 1, '2023-07-01', 145.00),
(1004, 3, '2023-01-14', 150.00),
(1005, 2, '2023-09-24', 120.00),
(1006, 1, '2023-06-19', 20.00);

# Q7.  Generate a report showing CustomerName, Email, and the TotalNumberofOrders for each customer. Include customers who have not placedany orders, in which case their TotalNumberofOrders should be 0. Order the resultsby CustomerName
SELECT 
    c.CustomerName,
    c.Email,
    COALESCE(COUNT(o.OrderID), 0) AS TotalNumberOfOrders
FROM Customers c
LEFT JOIN Orders o 
    ON c.CustomerID = o.CustomerID
GROUP BY 
    c.CustomerID, c.CustomerName, c.Email
ORDER BY 
    c.CustomerName;
    
    # Q8 Retrieve Product Information with Category: Write a SQL query to display the ProductName, Price, StockQuantity, and CategoryName for allproducts. Order the results by CategoryName and then ProductName alphabetically.
 SELECT 
    p.ProductName,
    p.Price,
    p.StockQuantity,
    c.CategoryName
FROM Products p
INNER JOIN Categories c 
    ON p.CategoryID = c.CategoryID
ORDER BY 
    c.CategoryName ASC,
    p.ProductName ASC;
    
    #Q9. Write a SQL query that uses a Common Table Expression (CTE) and a Window Function (specifically ROW_NUMBER() or RANK()) to display the CategoryName, ProductName, and Price for the top 2 most expensive products in each CategoryName
    WITH ProductRank AS (
    SELECT 
        c.CategoryName,
        p.ProductName,
        p.Price,
        ROW_NUMBER() OVER (
            PARTITION BY c.CategoryName 
            ORDER BY p.Price DESC
        ) AS rn
    FROM Products p
    JOIN Categories c 
        ON p.CategoryID = c.CategoryID
)
SELECT 
    CategoryName,
    ProductName,
    Price
FROM ProductRank
WHERE rn <= 2;

# Q10. 
use sakila;
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email,
    SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p 
    ON c.customer_id = p.customer_id
GROUP BY c.customer_id, customer_name, c.email
ORDER BY total_spent DESC
LIMIT 5;

SELECT 
    cat.name AS category_name,
    COUNT(r.rental_id) AS rental_count
FROM category cat
JOIN film_category fc 
    ON cat.category_id = fc.category_id
JOIN inventory i 
    ON fc.film_id = i.film_id
JOIN rental r 
    ON i.inventory_id = r.inventory_id
GROUP BY cat.name
ORDER BY rental_count DESC
LIMIT 3;

-- Total films per store
SELECT 
    s.store_id,
    COUNT(DISTINCT i.film_id) AS total_films
FROM store s
JOIN inventory i 
    ON s.store_id = i.store_id
GROUP BY s.store_id;

SELECT 
    s.store_id,
    COUNT(DISTINCT i.film_id) AS never_rented_films
FROM store s
JOIN inventory i 
    ON s.store_id = i.store_id
LEFT JOIN rental r 
    ON i.inventory_id = r.inventory_id
WHERE r.rental_id IS NULL
GROUP BY s.store_id;

SELECT 
    YEAR(payment_date) AS year,
    MONTH(payment_date) AS month,
    SUM(amount) AS total_revenue
FROM payment
WHERE YEAR(payment_date) = 2023
GROUP BY year, month
ORDER BY month;

SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(r.rental_id) AS rental_count
FROM customer c
JOIN rental r 
    ON c.customer_id = r.customer_id
WHERE r.rental_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY c.customer_id, customer_name
HAVING COUNT(r.rental_id) > 10
ORDER BY rental_count DESC;