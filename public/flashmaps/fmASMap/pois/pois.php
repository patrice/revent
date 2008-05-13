<POIs>
<?php
	include("../../include/fmDB.php");
	
	$area_str = "";
	$subarea_str = "";
	$level_str = "";
	if (!empty($_REQUEST["area"])) { $area_str = strtolower($_REQUEST["area"]); }
	if (!empty($_REQUEST["subarea"])) { $subarea_str = strtolower($_REQUEST["subarea"]); }
	if (!empty($_REQUEST["level"])) { $level_str = $_REQUEST["level"]; }

	$sql = "SELECT * FROM events WHERE latitude <> 0 AND longitude <> 0 ";
	if ($level_str == "2") { $sql = $sql . "AND state = '" . substr($area_str, 3, 2) . "' "; }
	if ($level_str == "3") { $sql = $sql . "AND state = '" . substr($subarea_str, 3, 2) . "' "; }
	$query = mysql_query($sql);
		
	if (mysql_num_rows($query) > 0) {
		while ($poi = mysql_fetch_array($query, MYSQL_BOTH)) {
		
			if ($level_str == "1") {
				echo "<POI id='" . $poi['id'] . "' category='event_state' label='" . htmlspecialchars($poi['name'],ENT_QUOTES) . "' lat='" . $poi['latitude'] . "' lon='" . $poi['longitude'] . "' />\n";
			} else {
				echo "<POI id='" . $poi['id'] . "' category='event_district' label='" . htmlspecialchars($poi['name'],ENT_QUOTES) . "' lat='" . $poi['latitude'] . "' lon='" . $poi['longitude'] . "' location='" . $poi['city'] . ", " . $poi['state'] . "' date='" . $poi['start'] . "' >\n";
				echo " <action event='onRelease' target='_blank' url='" . $poi['url'] . "' />\n";
				echo "</POI>\n";
			}
		}
	}
	mysql_free_result(mysql_query($sql));
	mysql_close();
?>
</POIs>