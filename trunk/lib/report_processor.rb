ENV['RAILS_ENV'] = ENV['RAILS_ENV'] || 'production'
require File.expand_path(File.dirname(__FILE__) + '/../config/boot')
require File.expand_path(File.dirname(__FILE__) + '/../config/environment')
ActiveRecord::Base.allow_concurrency = true

require 'starling_client'
require 'press_link'
class ReportProcessor
  def self.run
    Site.current = Site.find 2
    Tag
    queue = Starling.new 'localhost:22122'
    loop do
      data = queue.get 'reports'
      report = data[:report]
      attachments = data[:attachments]
      request = data[:request]
      puts "processing report #{report.id}"
      attachments.each do |a| 
        a[0].temp_data = a[1]
        a[0].save
        a[0].tags = a[0].tag_depot if a[0].tag_depot
      end
      report.attachments = attachments.collect {|a| a[0]}
      report.upload_images_to_flickr
      puts 'uploaded to flickr'
      spam = report.check_akismet(request)
      puts 'checked with akismet, got: ' + spam
    end
  end
end
