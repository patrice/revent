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
  map.home '', :controller => 'calendars', :action => 'show', :format => 'html'

  map.connect ':permalink/invites/flashmap/pois', :controller => 'invites', :action => 'flashmap_pois'
  map.connect ':permalink/invites/flashmap/areas/states', :controller => 'invites', :action => 'flashmap_area_states', :format => 'html'
  map.connect ':permalink/invites/flashmap/areas/districts/:state.xml', :controller => 'invites', :action => 'flashmap_area_districts', :format => 'html'
  map.connect ':permalink/invites/flashmap/areas/state/:state.xml', :controller => 'invites', :action => 'flashmap_area_state', :format => 'html'

  # see http://dev.rubyonrails.org/changeset/6594 for 
  # edge rails solution to using resources and namespace
#  map.resources :calendars, :path_prefix => "admin", :controller => "admin/calendars" do |cal|
#    cal.resources :events
#  end

# work-around for issue with namespace collisions occurring due to app/controller/admin_controller.rb 
# should be cleaned-up to work automatically with admin namespace and perhaps resources 
  map.connect 'admin/users/:action/:id.:format', :controller => 'admin/users'
  map.connect 'admin/users/:action.:format', :controller => 'admin/users'
  map.connect 'admin/users/:action/:id', :controller => 'admin/users'

  map.connect 'admin/:permalink/events/:action/:id.:format', :controller => 'admin/events'
  map.connect 'admin/:permalink/events/:action.:format', :controller => 'admin/events'
  map.connect 'admin/:permalink/events/:action/:id', :controller => 'admin/events'
 
  map.connect 'admin/calendars/:action/:id.:format', :controller => 'admin/calendars'
  map.connect 'admin/calendars/:action.:format', :controller => 'admin/calendars'
  map.connect 'admin/calendars/:action/:id', :controller => 'admin/calendars'

  map.connect 'admin/invites/:action/:id.:format', :controller => 'admin/invites'
  map.connect 'admin/invites/:action.:format', :controller => 'admin/invites'
  map.connect 'admin/invites/:action/:id', :controller => 'admin/invites'
# end of work-around

  map.with_options :controller => 'events', :action => 'new' do |m|
    m.signup ':permalink/signup'
    m.connect 'calendars/:calendar_id/signup'
    m.connect 'signup'
    m.connect 'signup.:format', :defaults => {:format => ''}
  end

  map.connect '/attachments/:id1/:id2/*file', :controller => 'attachments', :action => 'show', :requirements => { :id1 => /\d+/, :id2 => /\d+/ }
  map.connect '/attachments/:id/*file', :controller => 'attachments', :action => 'show', :requirements => { :id => /\d+/ }

  map.with_options :controller => 'account' do |m|
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

  map.zip_search ":permalink/events/search/zip/:zip",  :controller => "events",
                                        :action => "search",
                                        :requirements => { :zip => /\d{5}/ }
  map.state_search ":permalink/events/search/state/:state", :controller => "events",
                                           :action => "search",
                                           :requirements => { :state => /\w{2}/ }
  map.connect "events/search/zip/:zip",  :controller => "events",
                                        :action => "search",
                                        :requirements => { :zip => /\d{5}/ }
  map.connect "events/search/state/:state", :controller => "events",
                                           :action => "search",
                                           :requirements => { :state => /\w{2}/ }

  map.report_state_search ":permalink/reports/search/state/:state", :controller => "reports",
                                           :action => "search",
                                           :requirements => { :state => /\w{2}/ }
  map.report_zip_search ":permalink/reports/search/zip/:zip",  :controller => "reports",
                                        :action => "search",
                                        :requirements => { :zip => /\d{5}/ }
  map.connect "reports/search/state/:state", :controller => "reports",
                                           :action => "search",
                                           :requirements => { :state => /\w{2}/ }
  map.connect "reports/search/zip/:zip",  :controller => "reports",
                                        :action => "search",
                                        :requirements => { :zip => /\d{5}/ }

#  map.connect 'reports/new/:service/:service_foreign_key', :controller => "reports", :action => "new"
  map.report 'reports/:event_id', :controller => 'reports', :action => 'show', :requirements => {:event_id => /\d+/}, :defaults => {:event_id => nil}

  map.connect ':controller/page/:page', :action => 'list'
  map.connect ':controller/search/zip/:zip/:page', :action => 'search'

  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  map.connect ':controller/service.wsdl', :action => 'wsdl'

  # Routes for inviting policitians to an event
  map.totals ':permalink/invites/totals', :controller => 'invites', :action => 'totals', :format => 'html'
  map.invite ':permalink/events/:id/invite/:action/:politician_id', :controller => 'invites', :defaults => { :action => 'all', :politician_id => nil, :id => 'all' }
  map.connect ':permalink/invites/list/state/:state', :controller => 'invites', :action => 'list'
  map.connect ':permalink/invites/list/state/:state.:format', :controller => 'invites', :action => 'list'
  map.connect ':permalink/invites/list/zip/:postal_code', :controller => 'invites', :action => 'search'
  map.connect ':permalink/invites/list/zip/:postal_code.:format', :controller => 'invites', :action => 'search'
  map.connect ':permalink/invites/list/candidates/:office', :controller => 'invites', :action => 'candidates'
  map.connect ':permalink/invites/list/candidates/:office.:format', :controller => 'invites', :action => 'candidates'
  map.connect ':permalink/invites/list/senators', :controller => 'invites', :action => 'senators'
  map.connect ':permalink/invites/list/senators.:format', :controller => 'invites', :action => 'senators'


  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action.:format'
  map.connect ':controller/:action/:id'

  map.connect ':permalink', :controller => 'calendars', :action => 'show', :format => 'html'
  map.connect ':permalink/:controller/:action/:id.:format'
  map.connect ':permalink/:controller/:action.:format'
  map.connect ':permalink/:controller/:action/:id'
end
