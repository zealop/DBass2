<?php
	REQUIRE '../php/utils.php';
	
	$id = $_POST['ID'];
	$name = $_POST['Name'];
	$img = $_POST['Image'];
	$parent = $_POST['Parent'];
	
	/*input checking
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
	mysqli_query($connect, "SET FOREIGN_KEY_CHECKS =0");
	$sql = "UPDATE category SET categoryname='$name', categoryimage='$img',
parentcategory = '$parent' WHERE categoryid='$id'";
	if (mysqli_query($connect, $sql)) {
		echo "Record updated";
	} 
	else {
		echo "Error updating record: " . mysqli_error($connect);
	}
	mysqli_query($connect, "SET FOREIGN_KEY_CHECKS =1");
	finish:
	mysqli_close($connect);
	
?>

