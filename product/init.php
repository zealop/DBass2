<?php


	$connect = mysqli_connect("localhost", "root", "", "examples");
	if (!$connect) {
		die("Connection failed: " . mysqli_connect_error());
	}
	
	//unicode
	mysqli_set_charset($connect,"utf8");
	header('Content-Type: application/json; charset=utf-8');
	
	$sql = "SELECT * FROM product";;
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