CREATE DATABASE EcommerceDB;
USE EcommerceDB;

-- 1️⃣ Customer Table
CREATE TABLE Customer (
  CustomerID INT PRIMARY KEY AUTO_INCREMENT,
  CustomerName VARCHAR(100),
  Email VARCHAR(100) UNIQUE,
  Phone VARCHAR(20),
  Address VARCHAR(255)
);

-- 2️⃣ Product Table
CREATE TABLE Product (
  ProductID INT PRIMARY KEY AUTO_INCREMENT,
  ProductName VARCHAR(100),
  Category VARCHAR(50),
  Price DECIMAL(10,2),
  Stock INT
);

-- 3️⃣ Orders Table
CREATE TABLE Orders (
  OrderID INT PRIMARY KEY AUTO_INCREMENT,
  CustomerID INT,
  OrderDate DATE,
  Status VARCHAR(30),
  FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- 4️⃣ OrderItems Table (connects Orders & Products)
CREATE TABLE OrderItems (
  OrderItemID INT PRIMARY KEY AUTO_INCREMENT,
  OrderID INT,
  ProductID INT,
  Quantity INT,
  TotalPrice DECIMAL(10,2),
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
  FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- 5️⃣ Payment Table
CREATE TABLE Payment (
  PaymentID INT PRIMARY KEY AUTO_INCREMENT,
  OrderID INT,
  PaymentDate DATE,
  PaymentMethod VARCHAR(50),
  Amount DECIMAL(10,2),
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- INSERT Customers (with NULL Phone)
INSERT INTO Customer (CustomerName, Email, Phone, Address)
VALUES
('John Doe', 'john@example.com', NULL, 'Chennai'),
('Meera Raj', 'meera@gmail.com', '9876543210', 'Coimbatore');

-- INSERT Products
INSERT INTO Product (ProductName, Category, Price, Stock)
VALUES
('Laptop Sleeve', 'Accessories', 799.00, 50),
('Pen Drive 32GB', 'Electronics', 499.00, NULL);  -- NULL Stock

-- INSERT Orders
INSERT INTO Orders (CustomerID, OrderDate, Status)
VALUES
(1, '2025-11-15', 'Pending'),
(2, '2025-11-16', 'Delivered');

-- INSERT OrderItems
INSERT INTO OrderItems (OrderID, ProductID, Quantity, TotalPrice)
VALUES
(1, 1, 2, 1598.00),
(2, 2, 1, 499.00);

-- INSERT Payment
INSERT INTO Payment (OrderID, PaymentDate, PaymentMethod, Amount)
VALUES
(2, '2025-11-16', 'UPI', 499.00);

-- Update customer phone number
UPDATE Customer
SET Phone = '9000011122'
WHERE CustomerID = 1;

-- Update stock of a product where stock is NULL
UPDATE Product
SET Stock = 100
WHERE Stock IS NULL;

-- Update order status
UPDATE Orders
SET Status = 'Shipped'
WHERE OrderID = 1;

-- 
DELETE FROM Product
WHERE ProductID = 3;

-- Delete an order item
DELETE FROM OrderItems
WHERE OrderItemID = 1;


-- DELETE a customer safely
DELETE FROM Payment WHERE OrderID IN (SELECT OrderID FROM Orders WHERE CustomerID = 1);
DELETE FROM OrderItems WHERE OrderID IN (SELECT OrderID FROM Orders WHERE CustomerID = 1);
DELETE FROM Orders WHERE CustomerID = 1;
DELETE FROM Customer WHERE CustomerID = 1;

-- DELETE a product safely
DELETE FROM OrderItems WHERE ProductID = 3;
DELETE FROM Product WHERE ProductID = 3;

-- DELETE an order safely
DELETE FROM Payment WHERE OrderID = 2;
DELETE FROM OrderItems WHERE OrderID = 2;
DELETE FROM Orders WHERE OrderID = 2;

-- DELETE single order item
DELETE FROM OrderItems WHERE OrderItemID = 5;

-- DELETE single payment
DELETE FROM Payment WHERE PaymentID = 4;

