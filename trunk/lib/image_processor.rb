ENV['RAILS_ENV'] = ENV['RAILS_ENV'] || 'production'
require File.expand_path(File.dirname(__FILE__) + '/../config/boot')
require File.expand_path(File.dirname(__FILE__) + '/../config/environment')
ActiveRecord::Base.allow_concurrency = true

require 'starling_client'
require 'application'
require 'admin/events_controller'
class ImageProcessor
  def self.run
    Site.current = Site.find 2
    queue = Starling.new 'localhost:22122'
    loop do
      ts, images = queue.get 'images'
      puts 'zipping'
      c = Admin::EventsController.new
      c.instance_variable_set :@featured_images, images
      c.send :zip_em_up, ts
    end
  end
end
