require File.dirname(__FILE__) + '/../spec_helper'


describe EventSweeper do
  before(:all) do
  end

  describe "when an event is saved" do
    before do
      @permalink = 'permalink'
      @event_id = 3333

      @page_cache_directory = File.join(RAILS_ROOT,'tmp','cache')
      FileUtils.mkdir_p(page_cache_directory) unless File.exists?(@page_cache_directory)
      ActionController::Base.stub!(:page_cache_directory).and_return(@page_cache_directory)

      FileUtils.mkdir_p(@File.join(@page_cache_directory,@permalink,'calendars'))
      @page = File.join(@File.join(@page_cache_directory,@permalink,'calendars'))
      FileUtils.touch(File.join(@calendar_directory,'show.html'))
    end

    it "should delete the calendar show page" do
      page = File.join(@page_cache_directory,@permalink,'calendars','show.html')
      lambda {@event = create_event}.should expire_page(page)
    end
  end
end
