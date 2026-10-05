create database My_Ecommerce;
use My_Ecommerce;

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Cost DECIMAL(10, 2) NOT NULL,
    StockQuantity INT NOT NULL DEFAULT 0,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    ProductID INT NOT NULL,
    CustomerID INT NOT NULL,
    OrderDate DATETIME NOT NULL,
    Quantity INT NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    OrderStatus VARCHAR(20) NOT NULL DEFAULT 'Completed', -- Completed, Pending, Cancelled
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Returns (
    ReturnID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    ReturnDate DATETIME NOT NULL,
    Reason VARCHAR(100) NOT NULL,
    RefundAmount DECIMAL(10, 2) NOT NULL,
    Status VARCHAR(20) NOT NULL DEFAULT 'Processed', -- Processed, Rejected, Pending
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    OrderID INT NOT NULL UNIQUE,
    ProductID INT NOT NULL,
    SaleDate DATETIME NOT NULL,
    QuantitySold INT NOT NULL,
    GrossRevenue DECIMAL(10, 2) NOT NULL,
    NetRevenue DECIMAL(10, 2) NOT NULL, -- Revenue after potential returns/refunds
    ProfitMargin DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Products (ProductID, ProductName, Category, Price, Cost, StockQuantity) VALUES
(101, 'Wireless Noise-Canceling Headphones', 'Electronics', 199.99, 80.00, 150),
(102, 'Gaming Laptop', 'Electronics', 85000.00, 110.00, 45),
(103, 'Organic Green Tea (50 bags)', 'Groceries', 14.99, 4.50, 500),
(104, '4K Ultra HD Smart TV 55"', 'Electronics', 60000.00, 280.00, 30),
(105, 'Running Shoes - Men', 'Apparel', 89.95, 32.00, 200),
(106, 'Stainless Steel Water Bottle', 'Home & Kitchen', 24.99, 7.00, 350);
select*from Products;

INSERT INTO Orders (OrderID, ProductID, CustomerID, OrderDate, Quantity, TotalAmount, OrderStatus) VALUES
(1001, 101, 501, '2026-09-01 10:15:00', 1, 199.99, 'Completed'),
(1002, 103, 502, '2026-09-01 11:30:00', 2, 29.98, 'Completed'),
(1003, 102, 503, '2026-09-02 14:22:00', 1, 249.50, 'Completed'),
(1004, 105, 504, '2026-09-03 09:05:00', 1, 89.95, 'Completed'),
(1005, 104, 501, '2026-09-04 16:45:00', 1, 499.99, 'Completed'),
(1006, 106, 505, '2026-09-05 12:10:00', 3, 74.97, 'Completed'),
(1007, 101, 506, '2026-09-06 18:30:00', 1, 199.99, 'Completed');
select*from Orders;

INSERT INTO Returns (ReturnID, OrderID, ProductID, ReturnDate, Reason, RefundAmount, Status) VALUES
(2001, 1003, 102, '2026-09-05 11:00:00', 'Defective adjustment lever', 249.50, 'Processed'),
(2002, 1004, 105, '2026-09-08 15:20:00', 'Wrong size delivered', 89.95, 'Processed');
select*from Returns;

INSERT INTO Sales (SaleID, OrderID, ProductID, SaleDate, QuantitySold, GrossRevenue, NetRevenue, ProfitMargin) VALUES
(3001, 1001, 101, '2026-09-01 10:15:00', 1, 199.99, 199.99, 119.99),
(3002, 1002, 103, '2026-09-01 11:30:00', 2, 29.98, 29.98, 20.98),
(3003, 1003, 102, '2026-09-02 14:22:00', 1, 249.50, 0.00, -110.00), -- Full refund processed
(3004, 1004, 105, '2026-09-03 09:05:00', 1, 89.95, 0.00, -32.00),   -- Full refund processed
(3005, 1005, 104, '2026-09-04 16:45:00', 1, 499.99, 499.99, 219.99),
(3006, 1006, 106, '2026-09-05 12:10:00', 3, 74.97, 74.97, 53.97),
(3007, 1007, 101, '2026-09-06 18:30:00', 1, 199.99, 199.99, 119.99);
select*from Sales;