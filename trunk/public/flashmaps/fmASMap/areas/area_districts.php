<areas>
<?php
	include("../../include/fmDB.php");
	
	$id_str = "";
	if (!empty($_REQUEST["id"])) { $id_str = $_REQUEST["id"]; }

	$sql = "SELECT d.stateID, d.districtID, d.district, p.display_name, p.image_url FROM districts d, politicians p WHERE d.districtID = p.districtID AND p.state = '" . $id_str . "' AND d.stateID = 'us_" . strtolower($id_str) . "' GROUP BY d.stateID, d.districtID, d.district, p.display_name, p.image_url";
	$query = mysql_query($sql);
		
	if (mysql_num_rows($query) > 0) {
		while ($area = mysql_fetch_array($query, MYSQL_BOTH)) {
		
			$category_str = "0";
		
			$sql_dis = "SELECT COUNT(event_id) AS total, MAX(i.attending) AS att FROM politicians p, politician_invites i WHERE p.id = i.politician_id AND p.state = '" . $id_str . "' AND p.districtID = '" . $area['districtID'] . "'";
			$query_dis = mysql_query($sql_dis);
	
			if (mysql_num_rows($query_dis) > 0) {
				$dis = mysql_fetch_array($query_dis, MYSQL_BOTH);
				
				if ($dis['total'] > 0) {
					$category_str = "1";
					if ($dis['att'] == 1) { $category_str = "2"; }
				}
			}
			mysql_free_result(mysql_query($sql_dis));		
		
			echo "<area id='" . strtolower($area['stateID']) . "_" . strtolower($area['districtID']) . "' category='dis_" . $category_str . "' label='" . htmlspecialchars($area['district'],ENT_QUOTES) . "' state='" . $category_str . "' name='" . htmlspecialchars($area['display_name'],ENT_QUOTES) . "' image='" . htmlspecialchars($area['image_url'],ENT_QUOTES) . "' />\n";
		}
	}
	mysql_free_result(mysql_query($sql));
	mysql_close();
?>
</areas>