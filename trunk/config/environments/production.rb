# Settings specified here will take precedence over those in config/environment.rb

config.load_paths += %W( #{RAILS_ROOT}/vendor/rflickr-2006.02.01/lib #{RAILS_ROOT}/vendor/mime-types-1.15/lib #{RAILS_ROOT}/vendor/aws-s3-0.3.0/lib )
::USING_S3 = true

# The production environment is meant for finished, "live" apps.
# Code is not reloaded between requests
config.cache_classes = true

# Use a different logger for distributed setups
# config.logger = SyslogLogger.new

# Full error reports are disabled and caching is turned on
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = true
config.active_record.observers = :event_sweeper

# Enable serving of images, stylesheets, and javascripts from an asset server
# config.action_controller.asset_host                  = "http://assets.example.com"

# Disable delivery errors if you bad email addresses should just be ignored
# config.action_mailer.raise_delivery_errors = false

DIA_CONFIG = File.join(RAILS_ROOT,'config','democracyinaction-config.yml')
API_OPTS = YAML.load_file(DIA_CONFIG) if File.exists?(DIA_CONFIG)

ActionMailer::Base.delivery_method = :sendmail
#ActionMailer::Base.delivery_method = :smtp

#ActionMailer::Base.server_settings = {
#  :domain             => "stepitup2007.org",
#   :perform_deliveries => true,
#   :address            => 'smtp.engineyard.com',
#   :port               => 25 }

begin
  CACHE = MemCache.new ['10.0.128.233:11211','10.0.128.234:11211'], :namespace => 'daysofaction'
  require 'memcache_util'
  require 'mem_cache_fragment_store'
  ActionController::Base.fragment_cache_store = :mem_cache_fragment_store, CACHE
rescue
end

begin
  require 'flickr'
  Flickr::API_KEY='fcf5d360d3eb7543605059f2017ef971'
  Flickr::SHARED_SECRET='db8221678454fae6'
rescue MissingSourceFile
end
