ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'
ASSET_PATH = File.join(RAILS_ROOT, 'test/fixtures/tmp/assets') unless Object.const_defined?(:ASSET_PATH)

class ActionController::TestRequest
  def user_agent
    "Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-US; rv:1.8.1.4) Gecko/20070515 Firefox/2.0.0.4"
  end
  def referer
    host
  end
  def host
    super || Site.find(:first).host
  end
end

class Test::Unit::TestCase
  include AuthenticatedTestHelper

  # Transactional fixtures accelerate your tests by wrapping each test method
  # in a transaction that's rolled back on completion.  This ensures that the
  # test database remains unchanged so your fixtures don't have to be reloaded
  # between every test method.  Fewer database queries means faster tests.
  #
  # Read Mike Clark's excellent walkthrough at
  #   http://clarkware.com/cgi/blosxom/2005/10/24#Rails10FastTesting
  #
  # Every Active Record database supports transactions except MyISAM tables
  # in MySQL.  Turn off transactional fixtures in this case; however, if you
  # don't care one way or the other, switching from MyISAM to InnoDB tables
  # is recommended.
  self.use_transactional_fixtures = true

  # Instantiated fixtures are slow, but give you @david where otherwise you
  # would need people(:david).  If you don't want to migrate your existing
  # test cases which use the @david style and don't mind the speed hit (each
  # instantiated fixtures translates to a database query per test method),
  # then set this back to true.
  self.use_instantiated_fixtures  = false

  # Add more helper methods to be used by all tests here...

  def use_temp_file(path)
    temp_path = File.join(ASSET_PATH, File.basename(path))
    FileUtils.cp path, temp_path
    yield temp_path
  end

  def assert_file_exists(file, message = nil)
    message ||= "File not found: #{file}"
    assert File.file?(file), message
  end

  def assert_cached(url)
    assert page_cache_exists?(url), "#{url} is not cached"
  end

  def assert_not_cached(url)
    assert !page_cache_exists?(url), "#{url} is cached"
  end

  def page_cache_exists?(url)
    File.exists? page_cache_test_file(url)
  end

  def page_cache_test_file(url)
    File.join ActionController::Base.page_cache_directory, page_cache_file(url).reverse.chomp('/').reverse
  end

  def page_cache_file(url)
    ActionController::Base.send :page_cache_file, url.gsub(/$https?:\/\//, '')
  end

  def assert_caches_pages(*urls)
    yield(urls) if block_given?
    urls.map { |url| assert_cached url }
  end

  def assert_expires_pages(*urls)
    yield(urls) if block_given?
    urls.map { |url| assert_not_cached url }
  end
end
