
 /*
Customers (customer_id, name, email, city)
Orders (order_id, customer_id, order_date, total_amount)
Products (product_id, product_name, category, price)
Order_Items (item_id, order_id, product_id, quantity, price)
*/
/* Create an e-commerce database */
CREATE DATABASE EcommerceDB;
SHOW DATABASES;
USE EcommerceDB;
 
# Customers Table
CREATE TABLE Customers (
customer_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(100),
email VARCHAR(100) UNIQUE,
city VARCHAR(100)	
);
 
SHOW TABLES;
 
# Orders Table
CREATE TABLE Orders (
order_id INT PRIMARY KEY AUTO_INCREMENT,
customer_id INT,
order_date DATE,
total_amount DECIMAL(10,2),	
FOREIGN KEY(customer_id) REFERENCES CUSTOMERS(customer_id)
);
 
# Products Table 
CREATE TABLE Products(
product_id INT PRIMARY KEY AUTO_INCREMENT,
product_name VARCHAR(100),
category VARCHAR(50),
price DECIMAL(10,2)
);
 
# Order_Items Table
CREATE TABLE Order_Items  (
item_id INT PRIMARY KEY AUTO_INCREMENT,
order_id INT,
product_id INT,
quantity INT,
price DECIMAL(10,2),
FOREIGN KEY(order_id) REFERENCES Orders(Order_id),
FOREIGN KEY(product_id) REFERENCES Products(product_id)
);
 
# Step 2 - Insert Sample Data
 
# Customers Table
INSERT INTO Customers(name, email, city) VALUES
( "Neeraja", "neeraja.n@gmail.com", "New Jersey"),
( "Vamsi", "vamsi.v@gmail.com", "New York"),
( "Chitti", "chitti.c@gmail.com", "Texas");
 
SELECT * FROM Customers;
DELETE FROM Customers;
 
SET SQL_SAFE_UPDATES = 0;
ALTER TABLE Customers AUTO_INCREMENT = 0;
 
 
# Products Table
INSERT INTO PRODUCTS (product_name, category, price) VALUES
('Laptop', 'Electronics', 800),
('Smartphone', 'Electronics', 700),
('Mouse', 'Accessories', 25),
('Keyboard', 'Accessories', 40);
 
SELECT * FROM Products;
 
# Orders Table
INSERT INTO Orders (customer_id, order_date, total_amount) VALUES
(1, '2024-01-10', 825),
(2, '2024-02-15', 1400),
(3, '2024-03-05', 740);
 
SELECT * FROM Orders;
DELETE FROM Orders;
ALTER TABLE Orders AUTO_INCREMENT = 0;
 
# Order_Items 
INSERT INTO Order_Items (order_id, product_id, quantity, price) VALUES
(3, 1, 1, 800),
(3, 3, 1, 25),
(4, 2, 2, 700),
(5, 4, 1, 40),
(4, 2, 1, 700);
SELECT * FROM Order_Items;
 
# Step - 3 Advanced SQl Queries
 
# Joins 
SELECT * FROM Customers;
SELECT * FROM Orders;
 
INSERT INTO Customers(name, email, city) VALUES
( "Gayi", "gayi.g@gmail.com", "Dallas");
 
# Inner Join
SELECT Customers.Customer_id, Customers.name, Orders.order_id, Orders.order_date
FROM Customers
Inner Join Orders ON Customers.customer_id = Orders.customer_id;
 
# Left Join
SELECT Customers.Customer_id, Customers.name, Orders.order_id, Orders.order_date
FROM Customers
Left Join Orders ON Customers.customer_id = Orders.customer_id;
 
 
# Right Join
SELECT Customers.Customer_id, Customers.name, Orders.order_id, Orders.order_date
FROM Customers
Right Join Orders ON Customers.customer_id = Orders.customer_id;
 
# Full Join
SELECT Customers.Customer_id, Customers.name, Orders.order_id, Orders.order_date
FROM Customers
Left Join Orders ON Customers.customer_id = Orders.customer_id
UNION
SELECT Customers.Customer_id, Customers.name, Orders.order_id, Orders.order_date
FROM Customers
Right Join Orders ON Customers.customer_id = Orders.customer_id;
 
# Cross Join
Select Customers.name,Customers.customer_id,
Orders.order_id,
Orders.total_amount
from Customers
Cross Join Orders;

/* Tables;
Customers (customer_id, name, email, city)
Orders (order_id, customer_id, order_date, total_amount)
*/
show databases;
use EcommerceDB;
select * from customers;
select * from orders;
# Scalar Subquery

 