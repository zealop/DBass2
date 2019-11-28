<?php
	$connect = mysqli_connect("localhost", "root", "", "examples");
	if (!$connect) {
		die("Connection failed: " . mysqli_connect_error());
	}
 
	$id2 = $_POST['id1'];
	$sql = "DELETE FROM cars WHERE id='$id2'";
	if (mysqli_query($connect, $sql)) {
		 echo "Record deleted";
	} else {
		echo "Error deleting record: " . mysqli_error($connect);
	}
	mysqli_close($connect);
	
?>
