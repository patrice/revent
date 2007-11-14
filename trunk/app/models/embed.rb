class Embed < ActiveRecord::Base
  belongs_to :report

  before_create :extract_youtube_video_id
  def extract_youtube_video_id
    require 'hpricot'
    doc = Hpricot(html)
    params_movie = doc.at "param[@name=movie]"
    embed = doc.at "embed"
    uri = params_movie['value'] if params_movie && params_movie['value'] =~ /youtube.com/
    uri ||= embed['src'] if embed && embed['src'] =~ /youtube.com/
    return unless uri
    youtube_video_id = uri.split('/').last 
    self.youtube_video_id ||= youtube_video_id
  end

  attr_accessor :tag_depot
end
