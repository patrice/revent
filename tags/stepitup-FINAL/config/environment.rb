# Be sure to restart your web server when you modify this file.

# Uncomment below to force Rails into production mode when 
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
#RAILS_GEM_VERSION = '1.2' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence those specified here
  
  # Skip frameworks you're not going to use (only works if using vendor/rails)
  # config.frameworks -= [ :action_web_service, :action_mailer ]

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )
  #config.load_paths += %W( #{RAILS_ROOT}/vendor/DIA )
  config.load_paths += %W( #{RAILS_ROOT}/vendor/DIA #{RAILS_ROOT}/vendor/rflickr-2006.02.01/lib #{RAILS_ROOT}/vendor/mime-types-1.15/lib #{RAILS_ROOT}/vendor/aws-s3-0.3.0/lib )
#  config.load_paths += %W( #{RAILS_ROOT}/vendor/rails/activeresource/lib )

  # Force all environments to use the same logger level 
  # (by default production uses :info, the others :debug)
  # config.log_level = :debug

  # Use the database for sessions instead of the file system
  # (create the session table with 'rake db:sessions:create')
  config.action_controller.session_store = :active_record_store

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper, 
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector

  # Make Active Record use UTC-base instead of local time
  # config.active_record.default_timezone = :utc
  
  # See Rails::Configuration for more options
end

# Add new inflection rules using the following format 
# (all these examples are active by default):
# Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end
Inflector.inflections do |inflect|
  inflect.plural /^(.*) of (.*)/i, '\1s of \2'
end

# Mime::Type.register "text/richtext", :rtf

# Include your application configuration below
include Cartographer
ExceptionNotifier.exception_recipients = %w(seth@radicaldesigns.org)
ExceptionNotifier.email_prefix = "[ERROR - StepItUp] "

module ActionView::Helpers::AssetTagHelper
  def theme_image_path(source, theme=nil)
    "http://s3.amazonaws.com/stepitup2007.org/#{source}"
  end
  def theme_javascript_path( source, theme=nil )
    "http://s3.amazonaws.com/stepitup2007.org/#{source}.js"
  end
  def theme_stylesheet_path( source=nil, theme=nil )
    "http://s3.amazonaws.com/stepitup2007.org/#{source}.css"
  end
end