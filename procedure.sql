#cau 1
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
		IF  discount < 0 OR discount > 0.5 THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Discount must be between 0-50%';
		END IF;
		IF RIGHT(image, 4) != '.jpg' THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Images must be in JPG format';
		END IF;
		INSERT INTO product (productid, productname, productprice, productstock, productdesc, productimage, productdiscount) 
		VALUES (id, name, price, stock, descript, image, discount); 
	END$$
DELIMITER ;
#cau 2
#xoa quan he pro/cat sau khi xoa pro
DROP TRIGGER IF EXISTS clean_product;
DELIMITER $$
CREATE TRIGGER `clean_product` BEFORE DELETE ON `product` 
	FOR EACH ROW
	BEGIN
		DELETE FROM productcategory WHERE ProductID = OLD.ProductID;
	END$$
DELIMITER ;

#dieu chinh stock cua pro sau khi supply
DROP TRIGGER IF EXISTS supply_product;
DELIMITER $$
CREATE TRIGGER `supply_product` AFTER INSERT ON `supply` 
	FOR EACH ROW
	BEGIN
		UPDATE product SET ProductStock = ProductStock + NEW.SupplyCount;
	END$$
DELIMITER ;
#cau 3
#xem danh sach product cua 1 cat, input la catID
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

#xem cac product co luot review > n
DROP PROCEDURE IF EXISTS cat_detail;
DELIMITER $$
CREATE PROCEDURE pro_review(IN n int(12))
BEGIN
	SELECT COUNT(feedback.ProductID), product.ProductID
	FROM Product, Feedback
	GROUP BY product.ProductID
	HAVING COUNT(feedback.ProductID) > 5
	ORDER BY COUNT(feedback.ProductID);
	END$$
DELIMITER ;


