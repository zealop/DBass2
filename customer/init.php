<?php

	REQUIRE '../php/utils.php';
	
	$sql = "SELECT * FROM customer";
    $result = mysqli_query($connect, $sql);
    $rows = array();
    if (mysqli_num_rows($result) > 0){
        while($r = mysqli_fetch_assoc($result)){
            array_push($rows, $r);
        }
    }
    print json_encode($rows, JSON_UNESCAPED_UNICODE);
	mysqli_close($connect)
?>