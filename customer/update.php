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
	$sql = "UPDATE customer SET Username='$username', CPassword='$password', Email='$email', 
	PhoneNum='$phone', City='$city', Street='$street', ApartmentNum='$ano', Fullname='$fname', 
	Birthdate='$bday', Sex='$sex', DischargeAmount='$discharge' WHERE customerid = '$id'";
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

