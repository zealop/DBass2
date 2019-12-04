CREATE DATABASE `examples`;
USE `examples`;
CREATE TABLE `cars` (
   `id` int UNIQUE NOT NULL,
   `name` varchar(40),
   `year` varchar(50),
   PRIMARY KEY(id)
);
INSERT INTO cars VALUES(1,'Mercedes','2000');
INSERT INTO cars VALUES(2,'BMW','2004');
INSERT INTO cars VALUES(3,'Audi','2001');

CREATE TABLE Products (
	ProductID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,    
	ProductName   VARCHAR(255) NOT NULL DEFAULT '', 
	CategoryID INT FOREIGN KEY REFERENCES Category(CategoryID), 
	SupplierID INT FOREIGN KEY REFERENCES Supplier(SupplierID)
);