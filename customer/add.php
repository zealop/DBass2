<?php
	REQUIRE '../php/utils.php';
	
	$id = $_POST['ID'];
	$username = $_POST['Username'];
	$password = $_POST['Password'];
	$email= $_POST['Email'];
	$phone = $_POST['Phone'];
	$city = $_POST['City'];
	$street = $_POST['Street'];
	$ano = $_POST['ANo'];
	$fname = $_POST['FName'];
	$bday= $_POST['BDay'];
	$sex = $_POST['Sex'];
	$discharge = $_POST['Discharge'];
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
	
	$sql = "CALL add_customer('$id', '$username', '$password', '$email', '$phone', '$city', '$street', '$ano', '$fname', '$bday', '$sex', '$discharge')";
	
	if (mysqli_query($connect, $sql)) {
		echo "New record added";
	} 
	else {
		echo "Error adding new record: " . mysqli_error($connect);
	}
	finish:
		mysqli_close($connect);
	
?>