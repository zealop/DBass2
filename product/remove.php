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
	
	mysqli_query($connect, "SET FOREIGN_KEY_CHECKS =0");
	$sql = "DELETE FROM product WHERE productid='$id'";
	
	
	if (mysqli_query($connect, $sql)) {
		 echo "Record deleted";
	} else {
		echo "Error deleting record: " . mysqli_error($connect);
	}
	mysqli_query($connect, "SET FOREIGN_KEY_CHECKS =1");
	mysqli_close($connect);
	
?>
