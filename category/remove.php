<?php
	REQUIRE '../php/utils.php';
	
	$id = $_POST['ID'];
	
	mysqli_query($connect, "SET FOREIGN_KEY_CHECKS =0");
	$sql = "DELETE FROM category WHERE categoryid='$id'";
	
	
	if (mysqli_query($connect, $sql)) {
		 echo "Record deleted";
	} else {
		echo "Error deleting record: " . mysqli_error($connect);
	}
	mysqli_query($connect, "SET FOREIGN_KEY_CHECKS =1");
	mysqli_close($connect);
	
?>
