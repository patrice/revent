<?php
	include("../../include/fmDB.php");

	$id_str = "";
	if (!empty($_REQUEST["id"])) { $id_str = $_REQUEST["id"]; }
	
	echo "<theme id='" . $id_str . "'>\n";
	echo "<map file='areas/districts/fm-USACongressDistricts_" . strtolower($id_str) . ".swf' borderColor='0xCCCCCC' />\n";
	echo "<areas xmlAreas='areas/area_districts.php?id=" . strtolower($id_str) . "' xmlCategories='areas/area_categories.xml' />\n";
  #echo "<pois xmlPOIs='pois/pois.php' xmlCategories='pois/poi_categories.xml' />\n";
	echo "<pois xmlPOIs='/nov3/invites/flashmap/pois' xmlCategories='pois/poi_categories.xml' />\n";
	echo "<polylines xmlPolylines='' xmlCategories='' />\n";
	echo "</theme>\n";
?>
