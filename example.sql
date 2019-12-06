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
	CategoryImage varchar(100) DEFAULT NULL,
	ParentCategory int(12) DEFAULT NULL, 
	PRIMARY KEY(CategoryID),
	FOREIGN KEY(ParentCategory) REFERENCES Category(CategoryID)
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
DELIMITER @@;

CREATE TRIGGER `clean_product` BEFORE DELETE ON `product` FOR EACH ROW
DELETE FROM productcategory WHERE ProductID = OLD.ProductID;@@;
  

CREATE TRIGGER `clean_procatmapping2` BEFORE DELETE ON `category` FOR EACH ROW
BEGIN
	DELETE FROM
	productcategory
	WHERE
	CategoryID = OLD.CategoryID;
	UPDATE
	category
	SET parentcategory = NULL WHERE parentcategory = OLD.categoryID;
END;@@;
DELIMITER ;