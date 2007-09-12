<?php

	//database variables
	$host = "localhost";
	$db   = "radicaldesigns";
	$user = "root";
	$pass = "flashmaps";
	
	//database - connect
	$sqlConnectMySQL = mysql_connect($host, $user, $pass);
	mysql_select_db($db);
?>