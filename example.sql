DROP DATABASE examples;
CREATE DATABASE examples;
USE examples;
CREATE TABLE IF NOT EXISTS Product (
	ProductID int(12) NOT NULL AUTO_INCREMENT,
	ProductName varchar(100) COLLATE utf8_unicode_ci NOT NULL,
	ProductPrice int(12) COLLATE utf8_unicode_ci NOT NULL,
	ProductDesc text COLLATE utf8_unicode_ci NOT NULL,
	ProductImage varchar(100) DEFAULT NULL,
	ProductStock int(12) DEFAULT NULL,
	PRIMARY KEY (ProductID)
);

CREATE TABLE IF NOT EXISTS Category (
	CategoryID int(12) NOT NULL AUTO_INCREMENT,
	CategoryName varchar(100) COLLATE utf8_unicode_ci NOT NULL,
	CategoryDesc varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
	CategoryImage varchar(100) DEFAULT NULL,
	ParentCategory int(12) DEFAULT NULL, 
	PRIMARY KEY(CategoryID),
	FOREIGN KEY(ParentCategory) REFERENCES Category(CategoryID)
);

CREATE TABLE IF NOT EXISTS ProductCategory(
	ProductID int(12) NOT NULL, 
	CategoryID int(12) NOT NULL, 
	FOREIGN KEY(ProductID) REFERENCES Product(ProductID),
	FOREIGN KEY(CategoryID) REFERENCES Category(CategoryID)
);

CREATE TRIGGER `clean_procatmapping` BEFORE DELETE ON `product` FOR EACH ROW
DELETE FROM
  productcategory
WHERE
  ProductID = OLD.ProductID