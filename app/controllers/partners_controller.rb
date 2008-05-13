class PartnersController < ApplicationController
  #skip_before_filter :calendar
  #skip_before_filter :set_cache_root

  before_filter :set_partner_cookie
  def set_partner_cookie
    cookies[:partner] = {:value => params[:id], :expires => 3.hours.from_now} if params[:id]
  end
  before_filter(:only => :index) {|c| c.request.env["HTTP_IF_MODIFIED_SINCE"] = nil} #don't 304
  caches_action :index
  def index
    file = File.join(RAILS_ROOT, 'themes', current_theme, 'views', 'partners', "#{params[:id]}.rhtml")
    if(File.exists?(file))
      render :file => file, :layout => true
    else
      if params[:permalink]
        redirect_to :permalink => @calendar.permalink, :controller => 'calendars', :action => 'show', :id => nil, :format => nil 
      else
        redirect_to home_url
      end
    end
  end
end
