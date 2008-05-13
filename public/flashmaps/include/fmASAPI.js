// **********************************
// **  Flashmaps AreaSelector 1.0  **
// **     JavaScript Functions     **
// **********************************
// ** (c)2007 Flashmaps Geospatial **
// **   http://www.flashmaps.com   **
// **********************************

// *********************
// ** THEME functions **
// *********************

function fmThemeLoad(theme_xml) {
//do: load a new theme into the AS

	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideTheme", theme_xml);
	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideAction", "themeLoad");
	fmEngine.TCallLabel("_root." + fmASMcPath + "ASEngine_mc.outside_mc", "doAction");
}

function fmThemeReloadAreas(areas_xml) {
//do: reload the areas of a theme

	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideAreasXML", areas_xml);
	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideAction", "themeReloadAreas");
	fmEngine.TCallLabel("_root." + fmASMcPath + "ASEngine_mc.outside_mc", "doAction");

}

function fmThemeReloadPOIs(pois_xml) {
//do: reload the pois of a theme

	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsidePOIsXML", pois_xml);
	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideAction", "themeReloadPOIs");
	fmEngine.TCallLabel("_root." + fmASMcPath + "ASEngine_mc.outside_mc", "doAction");
}

// *******************
// ** MAP functions **
// *******************

function fmInitialView() {
//do: return the map to initial view

	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideAction", "themeInitialView");
	fmEngine.TCallLabel("_root." + fmASMcPath + "ASEngine_mc.outside_mc", "doAction");
}

function fmMapBackLevel() {
//do: return the map one level back
	
	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideAction", "themeBackLevel");
	fmEngine.TCallLabel("_root." + fmASMcPath + "ASEngine_mc.outside_mc", "doAction");
}

// ************************
// ** MAP MODE functions **
// ************************

function fmMapModeZoom() {
//do: change the map mode to zoom mode

	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideAction", "modeZoom");
	fmEngine.TCallLabel("_root." + fmASMcPath + "ASEngine_mc.outside_mc", "doAction");
}

function fmMapModeSelect() {
//do: change the map mode to select mode

	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideAction", "modeSelect");
	fmEngine.TCallLabel("_root." + fmASMcPath + "ASEngine_mc.outside_mc", "doAction");
}

function fmMapModeExportListAreas() {
//do: return the list of areas selected

	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideAction", "modeExport");
	fmEngine.TCallLabel("_root." + fmASMcPath + "ASEngine_mc.outside_mc", "doAction");
	return fmEngine.GetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideAreasSelected");
}

function fmMapModeCleanAreas() {
//do: clean the list of areas selected

	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideAction", "modeClean");
	fmEngine.TCallLabel("_root." + fmASMcPath + "ASEngine_mc.outside_mc", "doAction");
}

// *********************
// ** AREAS functions **
// *********************

function fmAreaCenter(area_str) {
//do: center the map into an area

	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideArea", area_str);
	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideAction", "areaCenter");
	fmEngine.TCallLabel("_root." + fmASMcPath + "ASEngine_mc.outside_mc", "doAction");
}

function fmAreaBackAndCenter(area_str) {
//do: back a level and center the map into an area

	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideArea", area_str);
	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideAction", "areaBackAndCenter");
	fmEngine.TCallLabel("_root." + fmASMcPath + "ASEngine_mc.outside_mc", "doAction");
}

function fmAreaCenterLatLon(area_str, lat, lon, scale) {
//do: center the map into a latitude/longitude

	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideArea", area_str);
	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideLat", lat);
	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideLon", lon);
	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideScale", scale);
	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideAction", "areaCenterLatLon");
	fmEngine.TCallLabel("_root." + fmASMcPath + "ASEngine_mc.outside_mc", "doAction");
}

function fmAreaZoomIn(areas_array) {
//do: zoom in into the map (areas_str array)
	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideAreas", areas_array);
	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideAction", "areaZoomIn");
	fmEngine.TCallLabel("_root." + fmASMcPath + "ASEngine_mc.outside_mc", "doAction");
}

function fmAreaEnabled(area_str, enabled_str) {
//do: enabled / disabled an area

	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideArea", area_str);
	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideEnabled", enabled_str);
	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideAction", "areaEnabled");
	fmEngine.TCallLabel("_root." + fmASMcPath + "ASEngine_mc.outside_mc", "doAction");
}

function fmAreaColor(area_str, colorNormal, colorOver, colorPress, colorText) {
//do: change the color of an area

	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideArea", area_str);
	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideColorNormal", colorNormal);
	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideColorOver", colorOver);
	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideColorPress", colorPress);
	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideColorText", colorText);
	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideAction", "areaColor");
	fmEngine.TCallLabel("_root." + fmASMcPath + "ASEngine_mc.outside_mc", "doAction");
}

//********************
//** POIS FUNCTIONS **
//********************

function fmPOIsShowCategory(category_str) {
//do: show all pois of a category (* for all categories)
	
	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideCategory", category_str);
	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideAction", "POIsShowCategory");
	fmEngine.TCallLabel("_root." + fmASMcPath + "ASEngine_mc.outside_mc", "doAction");
}

function fmPOIsHideCategory(category_str) {
//do: hide all pois of a category (* for all categories)
	
	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideCategory", category_str);
	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideAction", "POIsHideCategory");
	fmEngine.TCallLabel("_root." + fmASMcPath + "ASEngine_mc.outside_mc", "doAction");
}

function fmPOIAddEvent(event_str, target_str, url_str, id_str) {
//do: add an event to a POI

	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideEvent", event_str);
	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideTarget", target_str);
	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideUrl", url_str);
	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideId", id_str);
	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideAction", "POIEvent");
	fmEngine.TCallLabel("_root." + fmASMcPath + "ASEngine_mc.outside_mc", "doAction");
}

//****************************
//** ALERT WINDOW FUNCTIONS **
//****************************

function fmShowAlert(title_str, text_str) {
//do: show an alert window
	
	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideTitle", title_str);
	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideText", text_str);
	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideAction", "showAlert");
	fmEngine.TCallLabel("_root." + fmASMcPath + "ASEngine_mc.outside_mc", "doAction");
}

function fmHideAlert() {
//do: hide an alert window
	
	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideAction", "hideAlert");
	fmEngine.TCallLabel("_root." + fmASMcPath + "ASEngine_mc.outside_mc", "doAction");
}

//****************************
//** ALERT WINDOW FUNCTIONS **
//****************************

function fmShowCrossHair(lat, lon, scale) {
//do: show an alert window
	
	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideLat", lat);
	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideLon", lon);
	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideScale", scale);
	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideAction", "showCrossHair");
	fmEngine.TCallLabel("_root." + fmASMcPath + "ASEngine_mc.outside_mc", "doAction");
}

function fmHideCrossHair() {
//do: hide the cross hair
	
	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideAction", "hideCrossHair");
	fmEngine.TCallLabel("_root." + fmASMcPath + "ASEngine_mc.outside_mc", "doAction");
}

//*********************
//** PRINT FUNCTIONS **
//*********************

function fmPrint() {
//do: print the current view

	fmEngine.SetVariable("_root." + fmASMcPath + "ASEngine_mc.outsideAction", "print");
	fmEngine.TCallLabel("_root." + fmASMcPath + "ASEngine_mc.outside_mc", "doAction");
}