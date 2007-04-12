ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.
  
  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # You can have the root of your site routed by hooking up '' 
  # -- just remember to delete public/index.html.
  # map.connect '', :controller => "welcome"

#  raise Calendar.find(:first).inspect => WORKS!!!
  map.home '', :controller => "events"

  map.with_options :controller => 'account' do |m|
    m.signup  '/signup',  :action => 'signup'
    m.login   '/login',   :action => 'login'
    m.logout  '/logout',  :action => 'logout'
    m.profile '/profile', :action => 'profile'
  end

  map.with_options :controller => 'account/events' do |m|
    m.connect '/profile/events/:id', :action => 'show', :requirements => {:id => /\d+/}
    m.connect '/profile/events/:action/:id'
  end
  map.with_options :controller => 'account/blogs' do |m|
    m.connect '/profile/blogs/:action/:id'
  end

  map.ally '/ally/:referrer', :controller => 'events', :action => 'ally', :defaults => {:referrer => ''}

  map.zip_search "events/search/zip/:zip",  :controller => "events",
                                        :action => "search",
                                        :requirements => { :zip => /\d{5}/ }
  map.state_search "events/search/state/:state", :controller => "events",
                                           :action => "search",
                                           :requirements => { :state => /\w{2}/ }

  map.report_state_search "reports/search/state/:state", :controller => "reports",
                                           :action => "search",
                                           :requirements => { :state => /\w{2}/ }

  map.connect 'reports/new/:service/:service_foreign_key', :controller => "reports", :action => "new"
  map.report 'reports/:event_id', :controller => 'reports', :action => 'show', :requirements => {:event_id => /\d+/}

  map.admin 'admin/:controller/:action/:id', :admin => true

  map.connect ':controller/page/:page', :action => 'index'
  map.connect ':controller/search/zip/:zip/:page', :action => 'search'

  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  map.connect ':controller/service.wsdl', :action => 'wsdl'

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action.:format'
  map.connect ':controller/:action/:id'
end
