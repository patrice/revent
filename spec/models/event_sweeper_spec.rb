require File.dirname(__FILE__) + '/../spec_helper'

def expire_page(cached_page)
  assert File.exists?(cached_page)
end

module CacheTest
  class ExpirePage
    def initialize(url)
      @url = url
    end
    def matches?()
      not File.exist?(url)
    end
    def failure_message
      "expected #{@url} to be expired"
    end
    def negative_failure_message
      "expected #{@url} to not be expired"
    end
  end
  def expire_page(url)
    CacheTest::ExpirePage.new(url)
  end
end
      
describe EventSweeper do
  include CacheTest
  #controller_name :calendars

  before(:all) do
    ActionController::Base.perform_caching
    ActionController::Base.page_cache_directory = File.join(RAILS_ROOT,'test','cache')
    #ActionController::Base.stub!(:page_cache_directory).and_return(File.join(RAILS_ROOT,'test','cache'))

    # need to post to calendars/show in order to test caching
    @calendar = create_calendar 
    raise @calendar.site.inspect
    @controller = CalendarsController.new

    @request = ActionController::TestRequest.new
    @request.host = @calendar.site.host
    @response = ActionController::TestResponse.new

    #Site.stub!(:find_by_host).and_return(@calendar.site)
  end

  describe "when an event is saved" do
    before do
      #raise @calendar.site.inspect
      #raise @calendar.inspect
      post :controller => 'calendars', :action => 'show', :permalink => @calendar.permalink
=begin
      @cached_dir = File.join(ActionController::Base.page_cache_directory,"#{@calendar.site.host}","#{@calendar.permalink}",'calendars')
      FileUtils.mkdir_p(@cached_dir)
      @map_page = File.join(@cached_dir, 'show.html')
      FileUtils.touch(@map_page)
=end
    end
    it "should delete the calendar show page" do
      lambda {create_event(:calendar => @calendar)}.should expire_page(@map_page)
    end
  end
end
