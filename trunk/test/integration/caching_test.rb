require File.dirname(__FILE__) + '/../test_helper'

require 'mocha'
require 'DIA_API_Simple'

class CachingTest < ActionController::IntegrationTest
  fixtures :events, :sites, :calendars

  def setup
    FileUtils.rm_rf   ActionController::Base.page_cache_directory rescue nil
    FileUtils.mkdir_p ActionController::Base.page_cache_directory
    @mock_dia_api = stub(:get => [
                      {'event_KEY' => '1111', 'Event_Name' => 'expire test new event', 'Address' => 'locaction', 'Description' => 'description', 'City' => 'city', 'State' => 'CA', 'Zip' => '94110', 'Start' => 1.hour.from_now, 'End' => 2.hours.from_now, 'Directions' => 'directions'},
                      {'event_KEY' => '1000', 'Event_Name' => 'expire test updated event', 'Address' => 'locaction', 'Description' => 'description', 'City' => 'city', 'State' => 'CA', 'Zip' => '94110', 'Start' => 1.hour.from_now, 'End' => 2.hours.from_now, 'Directions' => 'directions'}
    ])
    DIA_API_Simple.stubs(:new).returns(@mock_dia_api)
  end

  def test_should_expire_only_list_pages_and_fragments_on_create
    host! sites(:stepitup).host
    e = events(:stepitup)
    get "/"
    get "/events/flashmap.xml" #have to fake the flash request
    get "/events/search/state/AZ"
    get "/events/search/state/CA"
    get "/events/show/#{e.id}"
    get "/events/show/2"
    assert_caches_pages "/index.html", "/events/flashmap.xml", "/events/show/#{e.id}", "/events/search/state/AZ", "/events/search/state/CA", "/events/show/2"
    assert_expires_pages "/index.html", "/events/flashmap.xml", "/events/search/state/CA", "/events/show/#{e.id}" do
      event_count = Calendar.find(1).events.count
      Calendar.load_from_dia(1)
      assert_equal event_count + 1, Calendar.find(1).events.count
    end
    assert_caches_pages "/events/show/2", "/events/search/state/AZ"
  end

  def test_should_expire_only_show_on_update
  end
end