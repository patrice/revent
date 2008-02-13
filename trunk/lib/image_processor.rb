ENV['RAILS_ENV'] = ENV['RAILS_ENV'] || 'production'
require File.expand_path(File.dirname(__FILE__) + '/../config/boot')
require File.expand_path(File.dirname(__FILE__) + '/../config/environment')
ActiveRecord::Base.allow_concurrency = true

require 'starling_client'
require 'application'
require 'admin/events_controller'
require 'site'
class ImageProcessor
  def self.run
    queue = Starling.new 'localhost:22122'
    loop do
      data = queue.get 'images'
      Site.current = data[:site]
      puts 'zipping'
      c = Admin::EventsController.new
      c.instance_variable_set :@featured_images, data[:images]
      c.send :zip_em_up, data[:timestamp]
    end
  end
end
