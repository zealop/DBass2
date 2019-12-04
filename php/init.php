<?php
	$connect = mysqli_connect("localhost", "root", "", "examples");
	
	if (!$connect) {
		die("Connection failed: " . mysqli_connect_error());
	}

	$sql = "SELECT * FROM cars";
    $result = mysqli_query($connect, $sql);
    $rows = array();

    if (mysqli_num_rows($result) > 0){
        while($r = mysqli_fetch_assoc($result)){
            array_push($rows, $r);
        }
    }
    print json_encode($rows);
	
	mysqli_close($connect)
?>