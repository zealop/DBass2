<?php
	$connect = mysqli_connect("localhost", "root", "", "examples");
	if (!$connect) {
		die("Connection failed: " . mysqli_connect_error());
	}
	
	$_POST = json_decode(file_get_contents('php://input'), true);
	$id = $_POST['id'];
	$name = $_POST['name'];
	$year = $_POST['year'];
	
	$sql = "DELETE FROM cars WHERE id='$id'";
	if (mysqli_query($connect, $sql)) {
		 echo "Record deleted";
	} else {
		echo "Error deleting record: " . mysqli_error($connect);
	}
	mysqli_close($connect);
	
?>
