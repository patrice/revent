class InvitesCachingTest < Test::Unit::TestCase

	def test_this
	  @request.host = sites(:stepitup).host
	  e = events(:stepitup)
	  url = "/#{e.calendar.permalink}/events/show/#{e.id}"
	  assert_caches_pages "#{url}.html" do
	    get "#{url}"
	  end
	  assert_expires_pages "some pages" do
	    e.save
	  end
	end
end



=begin
 fill up cache directory with phoney files to test expiry/sweepers

require File.dirname(__FILE__) + '/../test_helper'

class EventSweeperTest < Test::Unit::TestCase
  fixtures :events

  def test_sweeping
    fill_up_the_page_caches
    assert_expires_pages(all_caches_pages) do
      Event.after_save
    end
  end

  protected
  def fill_up_the_page_caches
    ["/#{permalink}/events/show/#{id}.html", "/#{permalink}/index.html"].each do |url|
      file = File.join(ActionController.page_cache_directory, url)
      FileUtils.mk
    end
  end
end
=end
