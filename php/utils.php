<?php

	//connection
	$connect = mysqli_connect("localhost", "root", "", "examples");
	if (!$connect) {
		die("Connection failed: " . mysqli_connect_error());
	}
	
	//unicode
	mysqli_set_charset($connect,"utf8");
	header('Content-Type: application/json; charset=utf-8');
	
	//decode json send to server
	$_POST = json_decode(file_get_contents('php://input'), true);
?>