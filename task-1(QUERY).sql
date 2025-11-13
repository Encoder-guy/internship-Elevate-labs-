-- Create Database
CREATE DATABASE ecommerce_db;
USE ecommerce_db;

-- Table: Customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15),
    Address TEXT,
    City VARCHAR(50),
    State VARCHAR(50),
    PostalCode VARCHAR(10),
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Table: Categories
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL,
    Description TEXT
);

-- Table: Products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    CategoryID INT,
    Price DECIMAL(10,2) NOT NULL,
    Stock INT DEFAULT 0,
    Description TEXT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Table: Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    ShipperID INT,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Status VARCHAR(50) DEFAULT 'Pending',
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ShipperID) REFERENCES Shippers(ShipperID)
);

-- Table: Shippers
CREATE TABLE Shippers (
    ShipperID INT PRIMARY KEY,
    ShipperName VARCHAR(100) NOT NULL,
    Phone VARCHAR(15)
);

-- Table: OrderItems
CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Table: Payments
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    OrderID INT,
    PaymentDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    PaymentMethod VARCHAR(50),
    Amount DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders (OrderID)
);
