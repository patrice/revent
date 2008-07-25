# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'spec'
require 'spec/rails'
require 'ostruct'

Spec::Runner.configure do |config|
  # If you're not using ActiveRecord you should remove these
  # lines, delete config/database.yml and disable :active_record
  # in your config/boot.rb
  config.use_transactional_fixtures = false # needs to be off for remote salesforce testing to work 
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
  config.include FixtureReplacement

  # == Fixtures
  #
  # You can declare fixtures for each example_group like this:
  #   describe "...." do
  #     fixtures :table_a, :table_b
  #
  # Alternatively, if you prefer to declare them only once, you can
  # do so right here. Just uncomment the next line and replace the fixture
  # names with your fixtures.
  #
  #config.global_fixtures = :sites, :calendars
  #
  # If you declare global fixtures, be aware that they will be declared
  # for all of your examples, even those that don't use them.
  #
  # You can also declare which fixtures to use (for example fixtures for test/fixtures):
  #
  # config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
  #
  # == Mock Framework
  #
  # RSpec uses it's own mocking framework by default. If you prefer to
  # use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  #
  # == Notes
  # 
  # For more information take a look at Spec::Example::Configuration and Spec::Runner
end

def test_uploaded_file(file = 'arrow.jpg', content_type = 'image/jpg')
  ActionController::TestUploadedFile.new(File.join(RAILS_ROOT, 'spec', 'fixtures', 'attachments', file), content_type)
end

module CacheSpecHelpers
  def assert_cached(url) 
    assert page_cache_exists?(url), "#{url} is not cached"
  end

  def page_cache_expired?(url)
    not page_cache_exists?(url)
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

  def cache_url(url)
    dir = FileUtils.mkdir_p(File.join(ActionController::Base.page_cache_directory, File.dirname(url)))
    file = FileUtils.touch(File.join(dir, File.basename(url)))
    assert_cached url
  end

  def cache_urls(*urls)
    urls.each {|url| cache_url(url)}
  end
end

module CacheCustomMatchers
  class ExpirePages
    include CacheSpecHelpers
    def initialize(urls)
      @urls = urls 
    end
    def matches?(target)
      require 'ruby2ruby'
      @target = target.to_ruby
      target.call
      @expired_pages, @unexpired_pages = @urls.partition {|u| page_cache_expired?(u)}
      @unexpired_pages.empty?
    end
    def failure_message
      "#{@target.inspect} did not expire:\n#{@unexpired_pages.join("\n")}"
    end
    def negative_failure_message
      "#{@target.inspect} did expire:\n#{@unexpired_pages.join("\n\t")}"
    end
  end
  def expire_pages(urls)
    ExpirePages.new(urls)
  end
end
