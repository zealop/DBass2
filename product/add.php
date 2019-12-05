<?php
	$connect = mysqli_connect("localhost", "root", "", "examples");
	if (!$connect) {
		die("Connection failed: " . mysqli_connect_error());
	}
	
	mysqli_set_charset($connect,"utf8");
	header('Content-Type: application/json; charset=utf-8');
	
	$_POST = json_decode(file_get_contents('php://input'), true);
	
	$id = $_POST['id'];
	$name = $_POST['name'];
	$price = $_POST['price'];
	$stock= $_POST['stock'];
	$desc = $_POST['desc'];
	$img = $_POST['img'];
	
	/*
	//Perform check
	if(!is_numeric($id) || $id <= 0 || $id != round($id, 0)){
		echo "ID must be positive integer";
		goto finish;
	}		
	if(strlen($name)>40 || strlen($name)<5) {
		echo "Name must be between 5 to 40 characters long";
		goto finish;
	}
	if(!is_numeric($year) || $year < 1990 || $year > 2015 ||$year != round($year, 0)){
		echo "Year must be integer between 1990 to 2015";
		goto finish;
	}
	*/
	
	$sql = "INSERT INTO product (productid, productname, productprice, productstock, productdesc, productimage) 
	VALUES ('$id', '$name', '$price', '$stock', '$desc', '$img')";
	
	if (mysqli_query($connect, $sql)) {
		echo "New record added";
	} 
	else {
		echo "Error adding new record: " . mysqli_error($connect);
	}
	finish:
		mysqli_close($connect);
	
?>