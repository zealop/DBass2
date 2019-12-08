-- cau 1
USE examples;
DROP PROCEDURE IF EXISTS add_product;
DELIMITER $$
CREATE PROCEDURE add_product (	IN id int(12),
								IN name VARCHAR(100),
								IN price int(12),
								IN stock int(12),
								IN descript TEXT,
								IN image VARCHAR(100),
								IN discount DECIMAL(4,2))				
	BEGIN
		IF  discount = 1  THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Discount cant be 100%';
		END IF;
		IF  discount > 1 AND discount < 1000  THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Flat discount must be at least 1000VND';
		END IF;
		IF RIGHT(image, 4) != '.jpg' THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Images must be in JPG format';
		END IF;
		INSERT INTO product (productid, productname, productprice, productstock, productdesc, productimage, productdiscount) 
		VALUES (id, name, price, stock, descript, image, discount); 
	END$$
DELIMITER ;
-- cau 2:
-- xoa quan he pro/cat sau khi xoa pro:
DROP TRIGGER IF EXISTS clean_product;
DELIMITER $$
CREATE TRIGGER `clean_product` BEFORE DELETE ON `product` 
	FOR EACH ROW
	BEGIN
		DELETE FROM productcategory WHERE ProductID = OLD.ProductID;
	END$$
DELIMITER ;

-- dieu chinh stock cua pro sau khi supply:
DROP TRIGGER IF EXISTS supply_product;
DELIMITER $$
CREATE TRIGGER `supply_product` AFTER INSERT ON `supply` 
	FOR EACH ROW
	BEGIN
		UPDATE product SET ProductStock = ProductStock + NEW.SupplyCount;
	END$$
DELIMITER ;
-- cau 3:
-- xem danh sach product cua 1 cat, input la catID:
DROP PROCEDURE IF EXISTS cat_detail;
DELIMITER $$
CREATE PROCEDURE cat_detail(IN id int(12))
BEGIN
	SELECT Category.CategoryName, Product.ProductID, Product.ProductName 
	FROM category, product, productcategory 
	WHERE category.categoryid = id 
	AND category.categoryid = productcategory.categoryid 
	AND product.productid = productcategory.productid ORDER BY ProductID;
END$$
DELIMITER ;
-- xem cac product co luot review >= n:
DROP PROCEDURE IF EXISTS pro_review;
DELIMITER $$
CREATE PROCEDURE pro_review(IN n int(12))
BEGIN
	SELECT product.ProductID, product.ProductName, COUNT(feedback.ProductID) as Reviews
	FROM Product, Feedback
    WHERE feedback.ProductID = product.ProductID
	GROUP BY feedback.ProductID
	HAVING COUNT(feedback.ProductID) >= n
	ORDER BY COUNT(feedback.ProductID) DESC;
	END$$
DELIMITER ;
-- cau 4:
-- tinh gia that cua san pham :
DROP FUNCTION IF EXISTS true_price;
DELIMITER $$
CREATE FUNCTION `true_price`(`proID` INT(12))
RETURNS INT
BEGIN
	DECLARE `OGPrice` INT(12);
	DECLARE `TruePrice` INT(12);
	DECLARE `Discount` DECIMAL(12,2);
	SET `OGPrice` = (SELECT Product.ProductPrice FROM Product WHERE Product.ProductID = `proID`);
	SET `Discount` = (SELECT Product.ProductDiscount FROM Product WHERE Product.ProductID = `proID`);
	IF (`Discount` < 1 AND `Discount` != 0) THEN
		SET `TruePrice` = FLOOR(`OGPrice`*(1-`Discount`));
	ELSE 
		SET `TruePrice` = FLOOR(`OGPrice` - `Discount`);
	END IF;
	RETURN `TruePrice`;
END$$
DELIMITER ;

-- phan hang san pham:
DROP FUNCTION IF EXISTS pro_level;
DELIMITER $$
CREATE FUNCTION `pro_level`(`proid` INT(12), `thres1` INT(12), `thres2` INT(12)) 
RETURNS VARCHAR(25)
BEGIN 
	DECLARE `PriceClass` VARCHAR(25);
	DECLARE `Price` INT(12); 
	IF `thres1` >= `thres2` THEN
		SIGNAL SQLSTATE '45000' 
			SET MESSAGE_TEXT = 'Threshold 1 cant be higher than or equal to Threshold 2';
	END IF;
	SET `Price` = (SELECT Product.ProductPrice FROM Product WHERE Product.ProductID = `proID`); 
	IF `Price` < `thres1` THEN 
		SET `PriceClass` = 'Entry level';
	ELSEIF `Price` < `thres2` THEN 
		SET `PriceClass` = 'Midrange';
	ELSE 
		SET `PriceClass` = 'High end';
	END IF;
	RETURN `PriceClass` ; 
END$$
DELIMITER ;

-- Cau 1:
USE examples;
DROP PROCEDURE IF EXISTS add_customer;
DELIMITER $$
CREATE PROCEDURE add_customer (	IN id		int(12),
								IN nameuser VARCHAR(20),
								IN cpass	VARCHAR(20),
								IN email	VARCHAR(30),
								IN phone	VARCHAR(15),
								IN city		VARCHAR(30),
								IN street	VARCHAR(30),
								IN apartnum	VARCHAR(15),
								IN fullname VARCHAR(30),
								IN bdate	DATE,
								IN sex		CHAR(1),
								IN discharge int(12))				
	BEGIN
		IF RIGHT(email, 10) != '@gmail.com' THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email must be in "@gmail.com" format';
		END IF;
		INSERT INTO Customer(CustomerID, Username, CPassword, Email, PhoneNum, City, Street, ApartmentNum, FullName, Birthdate, Sex, DischargeAmount)
		VALUES (id, nameuser, cpass, email, phone, city, street, apartnum, fullname, bdate, sex, discharge); 
	END$$
DELIMITER ;
-- Cau 2:
-- Tang tong tien cua don hang sau khi them san pham
DROP TRIGGER IF EXISTS IncreaseOrderTotal;
DELIMITER $$
CREATE TRIGGER `IncreaseOrderTotal` AFTER INSERT ON `IncludeProducts`
	FOR EACH ROW
	BEGIN
		DECLARE `price` INT(12);
		SET `price` = (SELECT ProductPrice FROM Product WHERE ProductID = NEW.ProductID);
		UPDATE Orders SET OrderTotal = OrderTotal + NEW.Amount * `price`;
	END$$
DELIMITER ;

-- Kiem tra stock cua product truoc khi nhap hang
DROP TRIGGER IF EXISTS `CheckStock`;
DELIMITER $$
CREATE TRIGGER `CheckStock` BEFORE INSERT ON `Supply`
	FOR EACH ROW
	BEGIN
		DECLARE `prod_stock` INT;
		SET `prod_stock` = (SELECT ProductStock FROM Product WHERE ProductID = Supply.ProductID);
		IF (`prod_stock` > 100) THEN
			SIGNAL SQLSTATE '45000' 
			SET MESSAGE_TEXT = 'This product is in stock!';
		END IF;
	END$$
DELIMITER ;



-- Cau 3:
-- Xem danh sach product cua order
DROP PROCEDURE IF EXISTS `ShowProductsOfOrder`;
DELIMITER $$
CREATE PROCEDURE `ShowProductsOfOrder` (IN `OrderID` INT(12))
BEGIN
	SELECT Product.ProductID, Product.ProductName, Product.ProductPrice, IncludeProducts.Amount, IncludeProducts.Note
	FROM Orders, Product, IncludeProducts
	WHERE	Orders.OrderID = `OrderID` 
		AND Orders.OrderID = IncludeProducts.OrderID 
		AND Product.ProductID = IncludeProducts.ProductID 
	ORDER BY Product.ProductID;
END$$
DELIMITER ;

-- Xem danh sach order cua category co price trong khoang (min, max)
DROP PROCEDURE IF EXISTS `ShowProdsOfCate`;
DELIMITER $$
CREATE PROCEDURE `ShowProdsOfCate`(IN `CategoryID`	INT, `min_price` INT, `max_price`	INT)
BEGIN
	SELECT Category.CategoryName, Product.ProductID, Product.ProductName, Product.ProductPrice
	FROM Category, Product, ProductCategory
	WHERE	Category.CategoryID = `CategoryID` 
		AND Category.CategoryID = ProductCategory.CategoryID 
		AND Product.ProductID = ProductCategory.ProductID
		AND Product.ProductPrice >= `min_price`
		AND	Product.ProductPrice <= `max_price`
	ORDER BY Product.ProductPrice;
END$$
DELIMITER ;



-- Cau 4:
-- Ham tinh tong tien da thanh toan cua customer, input CustomerID
DROP FUNCTION IF EXISTS `SumDischarge`;
DELIMITER $$
CREATE FUNCTION `SumDischarge`(
    `CustID` INT(12)
)
RETURNS INT(12)
DETERMINISTIC
BEGIN
	DECLARE `SumDischarge` INT(12);
	SET `SumDischarge` = (SELECT SUM(OrderTotal) FROM Orders
	WHERE	CustomerID = `CustID`
		AND OrderStatus = 'Discharged');
	RETURN `SumDischarge`;
END$$
DELIMITER ;

-- Ham tra ve CustomerLevel, input CustomerID
DROP FUNCTION IF EXISTS `GetCustomerLevel`;
DELIMITER $$
CREATE FUNCTION `GetCustomerLevel`(
    `CustID` INT(12)
) 
RETURNS VARCHAR(10)
BEGIN
	DECLARE `DischargeAmount` INT(12);
	DECLARE `customerLevel` VARCHAR(10);
	SET `DischargeAmount` = (SELECT DischargeAmount FROM Customer WHERE CustomerID = `CustID`);
    IF `DischargeAmount` > 50000000 THEN
        SET `customerLevel` = 'PLATINUM';
    ELSEIF `DischargeAmount` >= 10000000 THEN
        SET `customerLevel` = 'GOLD';
    ELSE
        SET `customerLevel` = 'SILVER';
    END IF;
    RETURN `customerLevel`;
END$$
DELIMITER ;