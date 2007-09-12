<areas>
<?php
	include("../../include/fmDB.php");

	$actions = 0;
	$total_sen = 2;

	$sql = "SELECT COUNT(id) AS total FROM events";
	$query = mysql_query($sql);
		
	if (mysql_num_rows($query) > 0) {
		$event = mysql_fetch_array($query, MYSQL_BOTH);
		$actions = $event['total'];
	}
	mysql_free_result(mysql_query($sql));
	
	//*** STATES LIST ***
	$sql = "SELECT s.stateID, s.state, s.state_abrv, COUNT(d.districtID) AS total FROM states s, districts d WHERE s.stateID = d.stateID GROUP BY s.stateID, s.state, s.state_abrv";
	$query = mysql_query($sql);
		
	if (mysql_num_rows($query) > 0) {
		while ($area = mysql_fetch_array($query, MYSQL_BOTH)) {
		
			$state_rep = 0;
			$state_sen = 0;
		
			//*** REP. BY STATE IN EVENTS ***
			$sql_rep = "SELECT COUNT(i.id) AS total FROM politician_invites i, politicians p WHERE i.politician_id = p.id AND p.state = '" . $area['state_abrv'] . "' AND p.district_type = 'FH'";
			$query_rep = mysql_query($sql_rep);
		
			if (mysql_num_rows($query_rep) > 0) {
				$rep = mysql_fetch_array($query_rep, MYSQL_BOTH);
				$state_rep = $rep['total'];
			}
			mysql_free_result(mysql_query($sql_rep));
			
			//*** SEN. BY STATE IN EVENTS ***
			$sql_sen = "SELECT COUNT(i.id) AS total FROM politician_invites i, politicians p WHERE i.politician_id = p.id AND p.state = '" . $area['state_abrv'] . "' AND p.district_type = 'FS'";
			$query_sen = mysql_query($sql_sen);
		
			if (mysql_num_rows($query_sen) > 0) {
				$sen = mysql_fetch_array($query_sen, MYSQL_BOTH);
				$state_sen = $sen['total'];
			}
			mysql_free_result(mysql_query($sql_sen));
			
			//*** STATE PERCENT ***
			$percent = round((100 * ($state_sen + $state_rep)) / ($total_sen + $area['total']));
			if ($percent == 0) {
				$category_str = "state_0";
			} elseif ($percent > 0 && $percent < 33) {
				$category_str = "state_1_33";
			} elseif ($percent >= 33 && $percent < 66) {
				$category_str = "state_33_66";
			} else {
				$category_str = "state_66_100";
			}
		
			echo "<area id='" . strtolower($area['stateID']) . "' category='" . $category_str . "' label='" . htmlspecialchars($area['state'],ENT_QUOTES) . "' child='areas/fm-state.php?id=" . $area['state_abrv'] . "' total_sen='" . $total_sen . "' total_rep='" . $area['total'] . "' actions='" . $actions . "' state_sen='" . $state_sen . "' state_rep='" . $state_rep . "' />\n";
		}
	}
	mysql_free_result(mysql_query($sql));
	mysql_close();
?>
</areas>