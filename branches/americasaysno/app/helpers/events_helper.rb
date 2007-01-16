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
  end

  def state_centers
    EventsController::STATE_CENTERS
  end
end
