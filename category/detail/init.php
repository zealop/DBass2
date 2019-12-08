<?php

	REQUIRE '../../php/utils.php';
	
	$id = $_POST['CatID'];
	$sql = "CALL cat_detail('$id')";
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