class CalendarsController < ApplicationController
  def index
    return show if @calendar
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :create ],
         :redirect_to => { :action => :list }

  def list
    @calendars = @site.calendars
  end

  def events
    redirect_to :controller => :site, :action => :splash unless @calendar
    @events = @calendar.events
  end
end
