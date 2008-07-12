require File.dirname(__FILE__) + '/../spec_helper'

module CacheTest
  class ExpirePage
    def initialize(url)
      @url = url
    end
    def matches?(block)
      block.call
      !File.exist?(@url)
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
  fixtures :calendars
  include CacheTest

  describe "when an event is created" do
    before do
      @calendar = calendars(:siu_nov)
      @permalink = @calendar.permalink

      @page_cache_directory = File.join(RAILS_ROOT,'tmp','cache')
      FileUtils.mkdir_p(@page_cache_directory) unless File.exists?(@page_cache_directory)
      ActionController::Base.stub!(:page_cache_directory).and_return(@page_cache_directory)

      FileUtils.mkdir_p(File.join(@page_cache_directory,@permalink,'calendars'))
      @page = File.join(@page_cache_directory,@permalink,'calendars','show.html')
      FileUtils.touch(@page)
    end

    it "should expire the calendar show page" do
      pending
      lambda {@event = create_event}.should expire_page(@page)
    end
  end
end
