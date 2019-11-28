<?php
	$connect = mysqli_connect("localhost", "root", "", "examples");
	if (!$connect) {
		die("Connection failed: " . mysqli_connect_error());
	}
 
	$id2 = $_POST['id1'];
	$name2 = $_POST['name1'];
	$year2 = $_POST['year1'];
	
	//Check if positive integer
	if(!is_numeric($id2) || $id2 <= 0 || $id2 != round($id2, 0)){
		echo "ID must be positive integer";
		goto finish;
	}
		
	if(strlen($name2)>40 || strlen($name2)<5) {
		echo "Name must be between 5 to 40 characters long";
		goto finish;
	}
	
	//Check integer in range
	if(!is_numeric($year2) || $year2 < 1990 || $year2 > 2015 ||$year2 != round($year2, 0)){
		echo "Year must be integer between 1990 to 2015";
		goto finish;
	}
	
	$sql = "INSERT INTO cars (id, name, year) VALUES ('$id2', '$name2', '$year2')";
	if (mysqli_query($connect, $sql)) {
		echo "New record added";
	} 
	else {
		echo "Error adding new record: " . mysqli_error($connect);
	}

	finish:
		mysqli_close($connect);
	
?>