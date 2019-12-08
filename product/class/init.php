<?php

	REQUIRE '../../php/utils.php';
	
	$sql = "SELECT product.ProductID, product.ProductName, pro_level(product.ProductID, 3000000, 6000000) as Class FROM product";
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