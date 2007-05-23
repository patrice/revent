module EventsHelper
  def gmaps_state_click(map)
    html = []
    html << "<script type=\"text/javascript\">\n/* <![CDATA[ */\n"  
    html << "
function add_click_handler() { 
  GEvent.addListener(#{map.dom_id}, \"click\", function() { alert(\"You clicked the map.\"); });
}"
    html << "
if (typeof window.onload != 'function')
  window.onload = add_click_handler();
else {
  old_before_click_handler_#{@dom_id} = window.onload;
  window.onload = function() { 
    old_before_click_handler_#{@dom_id}(); 
    add_click_handler();
  }
}"      
    html << "/* ]]> */</script> "
    return @debug ? html.join("\n") : html.join.gsub(/\s+/, ' ')
  end

  def gmaps_auto_center_and_zoom(map)
=begin
    html = []
    html << "<script type=\"text/javascript\">\n/* <![CDATA[ */\n"  
    html << " var bounds = new GLatLngBounds();
    html << "/* ]]> */</script> "
    return @debug ? html.join("\n") : html.join.gsub(/\s+/, ' ')
=end
    latitudes = map.markers.collect {|m| m.position[0]}.compact.sort
    longitudes = map.markers.collect {|m| m.position[1]}.compact.sort
    html = []
    html << "<script type=\"text/javascript\">\n/* <![CDATA[ */\n"  
    html << "
function auto_center_and_zoom() { 
    var bounds = new GLatLngBounds(new GLatLng(#{latitudes.first}, #{longitudes.first}), new GLatLng(#{latitudes.last}, #{longitudes.last}));
    eventmap.setZoom(eventmap.getBoundsZoomLevel(bounds));
    eventmap.setCenter(bounds.getCenter());
}"
    html << "
if (typeof window.onload != 'function')
  window.onload = auto_center_and_zoom();
else {
  old_before_auto_center_and_zoom_#{@dom_id} = window.onload;
  window.onload = function() { 
    old_before_auto_center_and_zoom_#{@dom_id}(); 
    auto_center_and_zoom();
  }
}"      
    html << "/* ]]> */</script> "
    return @debug ? html.join("\n") : html.join.gsub(/\s+/, ' ')
  end

  def state_centers
    EventsController::STATE_CENTERS
  end
end
