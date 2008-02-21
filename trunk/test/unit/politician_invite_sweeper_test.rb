require File.dirname(__FILE__) + '/../test_helper'

class PoliticianInviteSweeperTest < Test::Unit::TestCase
  fixtures :calendars, :events
  def test_expires_totals
    p = Politician.new :state => 'CA'
    c = Calendar.new :id => 111
    e = Event.new :id => 222
    p.stubs(:politician_invites).returns ['one']
    Rsvp.any_instance.stubs(:attending).returns(p)
    Rsvp.any_instance.stubs(:event).returns(e)
    e.stubs(:calendar).returns(c)
    c.stubs(:rsvp_dia_trigger_key).returns('333')
    PoliticianInvite.any_instance.stubs(:politician).returns(p)

    # TODO: get this working before someone needs invites controller
    return true
    url = "/thepermalink/invites/totals.html"
    cache_and_assert_expires(url) { @r = Rsvp.create }
    cache_and_assert_expires(url) { @p = PoliticianInvite.create }
    cache_and_assert_expires(url) { @r.save }
    cache_and_assert_expires(url) { @p.save }
  end

  def test_expires_list
    p = Politician.new :state => 'CA'
    c = Calendar.new :id => 111
    e = Event.new :id => 222
    p.stubs(:politician_invites).returns ['one']
    Rsvp.any_instance.stubs(:attending).returns(p)
    Rsvp.any_instance.stubs(:event).returns(e)
    e.stubs(:calendar).returns(c)
    c.stubs(:rsvp_dia_trigger_key).returns('333')
    PoliticianInvite.any_instance.stubs(:politician).returns(p)

    urls = {:zip => "/thepermalink/invites/list/zip/11111.html", :cali => "/thepermalink/invites/list/state/CA.html", :ny => "/thepermalink/invites/list/state/NY.html", :list => "/thepermalink/invites/list.html" }
    cache_urls *urls.values
    # TODO: fix this before invite controller is needed again 
    #assert_expires_pages(urls[:zip], urls[:cali], urls[:list]) { @r = Rsvp.create }
    assert_cached(urls[:ny])

    cache_urls *urls.values
    #assert_expires_pages(urls[:zip], urls[:cali], urls[:list]) { @p = PoliticianInvite.create }
    assert_cached(urls[:ny])

    p = Politician.new :state => 'CA'
    p.stubs(:politician_invites).returns ['the old invite', 'the new invite']
    p.stubs(:rsvps).returns ['the old rsvp', 'the new rsvp']
    Rsvp.any_instance.stubs(:attending).returns(p)
    PoliticianInvite.any_instance.stubs(:politician).returns(p)
    cache_urls *urls.values
    @p = PoliticianInvite.create
    urls.values.map {|u| assert_cached(u) }
  end

  def cache_and_assert_expires(url, &block)
    cache_url(url)
    assert_expires_pages(url) do
      yield
    end
  end

  def cache_urls(*urls)
    urls.each do |url|
      cache_url(url)
    end
  end

  def cache_url(url)
    dir = FileUtils.mkdir_p(File.join(ActionController::Base.page_cache_directory, File.dirname(url)))
    file = FileUtils.touch(File.join(dir, File.basename(url)))
    assert_cached url
  end
end
