ENV['RAILS_ENV'] = ENV['RAILS_ENV'] || 'production'
require File.expand_path(File.dirname(__FILE__) + '/../config/boot')
require File.expand_path(File.dirname(__FILE__) + '/../config/environment')
ActiveRecord::Base.allow_concurrency = true

require 'starling_client'
require 'press_link'
class ReportProcessor
  def self.run
    Site.current = Site.find 2
    queue = Starling.new 'localhost:22122'
    loop do
      data = queue.get 'reports'
      report = data[:report]
      attachments = data[:attachments]
      request = data[:request]
      puts "processing report #{report.id}"
      attachments.each {|a| a[0].temp_data = a[1]; a[0].save; a[0].tags = a.tag_depot}
      report.embeds.each {|e| e.tags = e.tag_depot}
      report.attachments = attachments.collect {|a| a[0]}
      report.upload_images_to_flickr
      report.check_akismet(request)
    end
  end
end
