# Settings specified here will take precedence over those in config/environment.rb

# The test environment is used exclusively to run your application's
# test suite.  You never need to work with it otherwise.  Remember that
# your test database is "scratch space" for the test suite and is wiped
# and recreated between test runs.  Don't rely on the data there!
config.cache_classes = true

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_controller.perform_caching             = true
config.action_controller.page_cache_directory        = File.join(RAILS_ROOT, 'test/tmp/cache/pages')
config.action_controller.fragment_cache_store        = :file_store, File.join(RAILS_ROOT, 'test/tmp/cache/fragments')
config.active_record.observers = :calendar_sweeper, :event_sweeper,
    :report_sweeper, :politician_invite_sweeper, :rsvp_sweeper, :attachment_sweeper

# need to test dia functionality using test account
DIA_ENABLED = true  

# Tell ActionMailer not to deliver emails to the real world.
# The :test delivery method accumulates sent emails in the
# ActionMailer::Base.deliveries array.
config.action_mailer.delivery_method = :test

CACHE = MemCache.new ['127.0.0.1:11211'], :namespace => 'daysofaction_test'
require 'memcache_util'
require 'ruby-debug'
