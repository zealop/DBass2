<?php
	REQUIRE '../php/utils.php';
	
	$id = $_POST['ID'];
	$name = $_POST['Name'];
	$price = $_POST['Price'];
	$stock= $_POST['Stock'];
	$desc = $_POST['Description'];
	$img = $_POST['Image'];
	
	/*
	if (empty($name)) {
		echo "Name required";
		goto finish;
	}
	if(strlen($name)>40 || strlen($name)<5) {
		echo "Name must be between 5 to 40 characters long";
		goto finish;
	}
	
	//Check integer in range
	if (empty($year)) {
		echo "Year required";
		goto finish;
	}
	if(!is_numeric($year) || $year < 1990 || $year > 2015 ||$year != round($year, 0)){
		echo "Year must be integer between 1990 to 2015";
		goto finish;
	}
	*/
	
	$sql = "UPDATE product SET productname='$name', productprice='$price',
	productstock='$stock', productdesc='$desc', productimage='$img' WHERE productid='$id'";
	if (mysqli_query($connect, $sql)) {
		echo "Record updated";
	} 
	else {
		echo "Error updating record: " . mysqli_error($connect);
	}
	
	finish:
	mysqli_close($connect);
	
?>

