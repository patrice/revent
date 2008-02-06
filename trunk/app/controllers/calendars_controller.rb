class CalendarsController < ApplicationController
  caches_page :show

  def signup
    # same action post vs get
    if File.exists?(File.join(Theme.path_to_theme(@site.theme), 'views', 'calendars', @calendar.id.to_s, 'signup.liquid'))
      @content = Liquid::Template.parse(File.read(File.join(Theme.path_to_theme(@site.theme), 'views', 'calendars', @calendar.id.to_s, 'signup.liquid'))).render
      render :text => @content and return
    end
    render :file => "calendars/#{@calendar.id}/new" and return
    #XXX: boo, this sucks, move this
  rescue
    render "events/new"
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :create ],
         :redirect_to => { :action => :list }

  def show
    # event query is in events_controller#flashmap or inline in themes/#{theme}/views/calendars/show.rhtml
    @flashmap_data_url = url_for(:permalink => @calendar.permalink, :controller => 'events', :action => 'flashmap', :only_path => true)
  end
end
