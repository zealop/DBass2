USE `examples`;
INSERT INTO Category VALUES(
	10000000,
	'Linh kiện máy tính',
	NULL);
	
INSERT INTO Category VALUES(
	11000000,
	'Card màn hình',
	10000000);
	
INSERT INTO Category VALUES(
	11100000,
	'NVIDIA',
	11000000);
	
INSERT INTO Category VALUES(
	11110000,
	'RTX',
	11100000);
	
INSERT INTO Category VALUES(
	11120000,
	'GTX',
	11100000);
	
INSERT INTO Category VALUES(
	12000000,
	'Mainboard',
	10000000);	
	
INSERT INTO Category VALUES(
	12100000,
	'Intel',
	12000000);	
	
INSERT INTO Category VALUES(
	12110000,
	'LGA 1152',
	12100000);	
	
INSERT INTO Category VALUES(
	13000000,
	'Tản nhiệt',
	10000000);
	
INSERT INTO Category VALUES(
	13100000,
	'Tản nhiệt nước',
	13000000);
	
INSERT INTO Category VALUES(
	14000000,
	'Thùng máy',
	10000000);

INSERT INTO Product (ProductID, ProductName, ProductPrice, ProductDesc, ProductImage, ProductStock) VALUES(
	19040596,
	'Card màn hình ASUS GeForce RTX 2080 8GB GDDR6 DUAL EVO OC (DUAL-RTX2080-O8G-EVO)',
	22890000,
	'- Chip đồ họa: NVIDIA GeForce RTX 2080
	- Bộ nhớ: 8GB GDDR6 ( 256-bit )
	- GPU clock OC Mode - GPU Boost Clock : 1830 MHz , GPU Base Clock : 1515 MHz Gaming Mode (Default) - GPU Boost Clock : 1800 MHz , GPU Base Clock : 1515 MHz
	- Nguồn phụ: 1 x 6-pin + 1 x 8-pi',
	NULL, 6);
INSERT INTO ProductCategory (ProductID, CategoryID) VALUES(19040596, 11110000);

INSERT INTO Product (ProductID, ProductName, ProductPrice, ProductDesc, ProductImage, ProductStock) VALUES(
	19040602,
	'Card màn hình ASUS GeForce GTX 1660Ti 6GB GDDR6 ROG Strix (ROG-STRIX-GTX1660TI-6G-GAMING)',
	8970000,
	'- Chip đồ họa: NVIDIA GeForce GTX 1660Ti
	- Bộ nhớ: 6GB GDDR6 ( 192-bit )
	- GPU clock Chế độ OC - Xung Tăng cường GPU : 1800 MHZ , Xung Nền GPU : 1530 MHz Chế độ Chơi Game - Xung Tăng cường GPU : 1770 MHZ , Xung Nền GPU : 1500 MHz
	- Nguồn phụ: 1 x 8-pin',
	NULL, 12);
INSERT INTO ProductCategory (ProductID, CategoryID) VALUES(19040602, 11120000);	
	
INSERT INTO Product (ProductID, ProductName, ProductPrice, ProductDesc, ProductImage, ProductStock) VALUES(
	19040610,
	'Card màn hình ASUS GeForce GTX 1650 4GB GDDR5 ROG Strix (ROG-STRIX-GTX1650-4G-GAMING)',
	4860000,
	'- Chip đồ họa: NVIDIA GeForce GTX 1660Ti
	- Bộ nhớ: 6GB GDDR6 ( 192-bit )
	- GPU clock Chế độ OC - Xung Tăng cường GPU : 1800 MHZ , Xung Nền GPU : 1530 MHz Chế độ Chơi Game - Xung Tăng cường GPU : 1770 MHZ , Xung Nền GPU : 1500 MHz
	- Nguồn phụ: 1 x 8-pin',
	NULL, 22);
INSERT INTO ProductCategory (ProductID, CategoryID) VALUES(19040610, 11120000);	
	
INSERT INTO Product (ProductID, ProductName, ProductPrice, ProductDesc, ProductImage, ProductStock) VALUES(
	19040961,
	'Mainboard ASUS P11C-X/AUDIO',
	3990000,
	'- Chuẩn mainboard: ATX
	- Socket: LGA 1151-v2 , Chipset: C242
	- Hỗ trợ RAM: DDR4 , tối đa 64GB
	- Cổng cắm lưu trữ: 1 x M.2 SATA; 1 x M.2 SATA/NVMe; 6 x SATA 3 6Gb/s
	- Cổng xuất hình: 1 x VGA/D-sub',
	NULL, 11);
INSERT INTO ProductCategory (ProductID, CategoryID) VALUES(19040961, 12110000);		

INSERT INTO Product (ProductID, ProductName, ProductPrice, ProductDesc, ProductImage, ProductStock) VALUES(
	19041006,
	'Tản nước AIO ASUS ROG RYUJIN 360',
	7490000,
	'- OLED màu 1,77” để hiển thị dữ liệu thống kê hệ thống theo thời gian thực và hình ảnh hoặc hoạt ảnh cá nhân hóa - Quạt mini tích hợp giúp làm mát khu vưc VRM và M.2 lên tới 20°C - 3 quạt tản nhiệt Noctua iPPC 2000 PWM 120mm - Trung tâm điều khiển một chạm LiveDash đối với đèn và màn hình OLED - LED RGB và vỏ bơm mạ NCVM làm nổi bật vẻ đẹp, hiện đại - Được thiết kế tinh tế để bổ sung cho bo mạch chủ ROG tại tầng trung tâm giàn máy của bạn - Ống dẫn được bọc ngoài, gia cường để tăng thêm độ bền',
	NULL, 5);
INSERT INTO ProductCategory (ProductID, CategoryID) VALUES(19041006, 14000000);		

INSERT INTO Product (ProductID, ProductName, ProductPrice, ProductDesc, ProductImage, ProductStock) VALUES(
	19060270,
	'Mainboard ASUS EX-B365M-V5',
	1750000,
	'-Chuẩn mainboard: Micro-ATX
	- Socket: LGA 1151-v2 , Chipset: B365
	- Hỗ trợ RAM: DDR4 , tối đa 32GB
	- Cổng cắm lưu trữ: 1 x M.2 SATA/NVMe; 4 x SATA 3 6Gb/s; Hỗ trợ Intel Optane
	- Cổng xuất hình: 1 x HDMI; 1 x VGA/D-sub',
	NULL, 17);
INSERT INTO ProductCategory (ProductID, CategoryID) VALUES(19060270, 12110000);		
	
INSERT INTO Product (ProductID, ProductName, ProductPrice, ProductDesc, ProductImage, ProductStock) VALUES(
	19030232,
	'Case máy tính Asus TUF Gaming GT501',
	4350000,
	'-Loại case: Mid Tower
	- Hỗ trợ mainboard: ATX; Extended-ATX; Micro-ATX; Mini-ITX
	- Khay mở rộng tối đa: 4 x 3.5" , 3 x 2.5"
	- Cổng USB: 2 x USB 3.1 Gen 1
	- Số quạt tặng kèm: 1 x 140 mm; 3 x 120mm LED',
	NULL, 4);
INSERT INTO ProductCategory (ProductID, CategoryID) VALUES(19030232, 12110000);		

INSERT INTO Product (ProductID, ProductName, ProductPrice, ProductDesc, ProductImage, ProductStock) VALUES(
	19050521,
	'Mainboard ASRock H310CM-HDV',
	1439000,
	'- Chuẩn mainboard: Micro-ATX
	- Socket: LGA 1151-v2 , Chipset: H310
	- Hỗ trợ RAM: DDR4 , tối đa 64GB
	- Cổng cắm lưu trữ: 4 x SATA 3 6Gb/s
	- Cổng xuất hình: 1 x DVI-D; 1 x HDMI; 1 x VGA/D-sub',
	NULL, 11);
INSERT INTO ProductCategory (ProductID, CategoryID) VALUES(19050521, 12110000);		

INSERT INTO Feedback (ReviewID, ProductID, Rate, Review, CostumerID

