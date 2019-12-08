<?php

	REQUIRE '../../php/utils.php';
	
	$n = $_POST['n'];
	$sql = "CALL ShowProductsOfOrder('$n')";
    $result = mysqli_query($connect, $sql);
    $rows = array();
    if (mysqli_num_rows($result) > 0){
        while($r = mysqli_fetch_assoc($result)){
            array_push($rows, $r);
        }
    }
    print json_encode($rows);
	mysqli_close($connect);
?>