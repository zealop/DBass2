<?php
	$connect = mysqli_connect("localhost", "root", "", "examples");
	if (!$connect) {
		die("Connection failed: " . mysqli_connect_error());
	}
	$_POST = json_decode(file_get_contents('php://input'), true);
	$id = $_POST['id'];
	$name = $_POST['name'];
	$year = $_POST['year'];
	
	//Check if positive integer
	if(!is_numeric($id) || $id <= 0 || $id != round($id, 0)){
		echo "ID must be positive integer";
		goto finish;
	}
		
	if(strlen($name)>40 || strlen($name)<5) {
		echo "Name must be between 5 to 40 characters long";
		goto finish;
	}
	
	//Check integer in range
	if(!is_numeric($year) || $year < 1990 || $year > 2015 ||$year != round($year, 0)){
		echo "Year must be integer between 1990 to 2015";
		goto finish;
	}
	
	$sql = "INSERT INTO cars (id, name, year) VALUES ('$id', '$name', '$year')";
	
	if (mysqli_query($connect, $sql)) {
		echo "New record added";
	} 
	else {
		echo "Error adding new record: " . mysqli_error($connect);
	}
	finish:
		mysqli_close($connect);
	
?>