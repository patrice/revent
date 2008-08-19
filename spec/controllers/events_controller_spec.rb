require File.dirname(__FILE__) + '/../spec_helper.rb'

describe EventsController do
  before do
    @site       = new_site
    @site.calendars << (@calendar = new_calendar(:site => @site))
    request.host = @site.host
    Site.stub!(:find_by_host).and_return(@site)
  end

  it "should set site from host" do
    get :index
    @controller.site.host.should == @site.host
  end

  it "should show" do
    pending
    @event = new_event
    @calendar.stub!(:events).and_return(stub('events', :find => [@event]))
    get :show, :id => 111
  end
end
