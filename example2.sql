DROP DATABASE examples;
CREATE DATABASE examples;
USE examples;
CREATE TABLE Product (
	ProductID		int(12) NOT NULL,
	ProductName		VARCHAR(100) COLLATE utf8_unicode_ci NOT NULL,
	ProductPrice	int(12) NOT NULL CHECK(ProductPrice >=0),
	ProductDesc		TEXT COLLATE utf8_unicode_ci NOT NULL,
	ProductImage	VARCHAR(100) DEFAULT NULL,
	ProductStock	INT DEFAULT 0 CHECK(ProductStock >=0),
	ProductReview	INT	DEFAULT 0,
	ProductDiscount	DECIMAL(4,2) DEFAULT 0,
	PRIMARY KEY (ProductID)
);

CREATE TABLE Category (
	CategoryID		int(12) NOT NULL,
	CategoryName	VARCHAR(100) COLLATE utf8_unicode_ci NOT NULL,
	ParentCategory	int(12) DEFAULT NULL,
	PRIMARY KEY (CategoryID),
	CONSTRAINT	fk_cate_cateid FOREIGN KEY (ParentCategory) REFERENCES Category(CategoryID)
);

CREATE TABLE IF NOT EXISTS ProductCategory(
	ProCatID int(12) NOT NULL AUTO_INCREMENT,
	ProductID int(12) NOT NULL, 
	CategoryID int(12) NOT NULL, 
	FOREIGN KEY(ProductID) REFERENCES Product(ProductID),
	FOREIGN KEY(CategoryID) REFERENCES Category(CategoryID),
	PRIMARY KEY(ProCatID),
	UNIQUE(ProductID, CategoryID)
);

CREATE TABLE Bill (
	BillID			int(12) NOT NULL,
	BillDate		DATE NOT NULL,
	BillTotal		int(12) NOT NULL,
	ShipAddr		VARCHAR(100) COLLATE utf8_unicode_ci NOT NULL,
	PRIMARY KEY (BillID)
);

CREATE TABLE Discharge (
	OrderID			int(12) NOT NULL,
	BillID			int(12) NOT NULL,
	PRIMARY KEY		(OrderID, BillID),
	CONSTRAINT		fk_disc_bill_billid	FOREIGN KEY (BillID)
				REFERENCES Bill(BillID)
				ON DELETE CASCADE
);

CREATE TABLE ShipService (
	ShipID			int(12) NOT NULL,
	ShipAddr		VARCHAR(100) COLLATE utf8_unicode_ci NOT NULL,
	ShipperID		int(12) NOT NULL,
	ShipperName		VARCHAR(25)	COLLATE utf8_unicode_ci NOT NULL,
	ShipVehicle		VARCHAR(10) COLLATE utf8_unicode_ci,
	PRIMARY KEY (ShipID)
);

CREATE TABLE Ship (
	ShipID			int(12) NOT NULL,
	BillID			int(12) NOT NULL,
	PRIMARY KEY (ShipID, BillID),
	CONSTRAINT		fk_ship_serv_shipid	FOREIGN KEY (ShipID)
				REFERENCES ShipService(ShipID)
				ON DELETE CASCADE,
	CONSTRAINT		fk_ship_bill_billid	FOREIGN KEY (BillID)
				REFERENCES Bill(BillID)
				ON DELETE CASCADE
);

CREATE TABLE Feedback (
	ReviewID	int(12)		NOT NULL AUTO_INCREMENT,
	ProductID	int(12)		NOT NULL,
	Rate			INT		NOT NULL,
	Review			VARCHAR(100) COLLATE utf8_unicode_ci,
	CustomerID		int(12)	NOT NULL,
	PRIMARY KEY		(ReviewID), 
	CONSTRAINT		fk_feed_prod_prodid	FOREIGN KEY (ProductID)
				REFERENCES Product(ProductID)
				ON DELETE CASCADE
);

CREATE TABLE Orders (
	OrderID		int(12)		NOT NULL,
	OrderStatus VARCHAR(50)	COLLATE utf8_unicode_ci NOT NULL,
	OrderTotal	DECIMAL(10,2) NOT NULL,
	CustomerID	int(12)	NOT NULL,
	PRIMARY KEY	(OrderID)
);

CREATE TABLE IncludeProducts (
	OrderID		int(12)		NOT NULL,
	ProductID	int(12)		NOT NULL,
	Amount		int(12)		NOT NULL,
	Note		VARCHAR(100) COLLATE utf8_unicode_ci,
	PRIMARY KEY	(OrderID, ProductID),
	CONSTRAINT		fk_incl_prod_prodid	FOREIGN KEY (ProductID)
				REFERENCES Product(ProductID)
				ON DELETE CASCADE,
	CONSTRAINT		fk_incl_order_orderid	FOREIGN KEY (OrderID)
				REFERENCES Orders(OrderID)
				ON DELETE CASCADE
);

ALTER TABLE Discharge
ADD CONSTRAINT	fk_disc_order_orderid	FOREIGN KEY (OrderID)
										REFERENCES Orders(OrderID);

CREATE TABLE Supply (
	ProductID	int(12)		NOT NULL,
	SupplierID	int(12)		NOT NULL,
	SupplyCount	int(12)		NOT NULL,
	SupplyDate	DATE		NOT NULL,
	PRIMARY KEY	(ProductID, SupplierID),
	CONSTRAINT		fk_sup_prod_prodid	FOREIGN KEY (ProductID)
				REFERENCES Product(ProductID)
				ON DELETE CASCADE
);

CREATE TABLE Customer (
	CustomerID	int(12)		NOT NULL,
	Username	VARCHAR(20)	NOT NULL,
	CPassword	VARCHAR(20) NOT NULL,
	Email		VARCHAR(30)	NOT NULL,
	PhoneNum	VARCHAR(15)	NOT NULL,
	Country		VARCHAR(15)	COLLATE utf8_unicode_ci NOT NULL,
	City		VARCHAR(15)	COLLATE utf8_unicode_ci NOT NULL,
	Street		VARCHAR(15) COLLATE utf8_unicode_ci,
	ApartmentNum	VARCHAR(10),
	Fullname	VARCHAR(30)	COLLATE utf8_unicode_ci NOT NULL,
	Birthdate	DATE		NOT NULL,
	Sex			CHAR(1)		NOT NULL,
	CustomerLevel	VARCHAR(10) COLLATE utf8_unicode_ci,
	DischargeAmount		DECIMAL(10,2),
	PRIMARY KEY		(CustomerID)
);

ALTER TABLE Orders
ADD CONSTRAINT	fk_order_cust_custmid	FOREIGN KEY (CustomerID)
										REFERENCES Customer(CustomerID);
ALTER TABLE Feedback
ADD CONSTRAINT	fk_feed_cust_custmid	FOREIGN KEY (CustomerID)
										REFERENCES Customer(CustomerID);

CREATE TABLE Supplier (
	SupplierID	int(12)		NOT NULL,
	Username	VARCHAR(20)	NOT NULL,
	SPassword	VARCHAR(20) NOT NULL,
	Email		VARCHAR(30)	NOT NULL,
	PhoneNum	VARCHAR(15)	NOT NULL,
	Country		VARCHAR(15) COLLATE utf8_unicode_ci NOT NULL,
	City		VARCHAR(15)	COLLATE utf8_unicode_ci NOT NULL,
	Street		VARCHAR(15) COLLATE utf8_unicode_ci,
	ApartmentNum	VARCHAR(10),
	CompanyName		VARCHAR(100) COLLATE utf8_unicode_ci NOT NULL,
	TaxNumber		VARCHAR(15) NOT NULL,
	PRIMARY KEY		(SupplierID)
);

ALTER TABLE Supply
ADD CONSTRAINT	fk_sup_supp_suppid	FOREIGN KEY (SupplierID)
									REFERENCES Supplier(SupplierID);
