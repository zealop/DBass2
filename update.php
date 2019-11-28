<?php
	$connect = mysqli_connect("localhost", "root", "", "examples");
	if (!$connect) {
		die("Connection failed: " . mysqli_connect_error());
	}
 
	$id2 = $_POST['id1'];
	$name2 = $_POST['name1'];
	$year2 = $_POST['year1'];
	
	if (empty($name2)) {
		echo "Name required";
		goto finish;
	}
	if(strlen($name2)>40 || strlen($name2)<5) {
		echo "Name must be between 5 to 40 characters long";
		goto finish;
	}
	
	//Check integer in range
	if (empty($year2)) {
		echo "Year required";
		goto finish;
	}
	if(!is_numeric($year2) || $year2 < 1990 || $year2 > 2015 ||$year2 != round($year2, 0)){
		echo "Year must be integer between 1990 to 2015";
		goto finish;
	}
	
	$sql = "UPDATE cars SET name='$name2', year='$year2' WHERE id='$id2'";
	if (mysqli_query($connect, $sql)) {
		echo "Record updated";
	} 
	else {
		echo "Error updating record: " . mysqli_error($connect);
	}
	
	finish:
	mysqli_close($connect);
	
?>

