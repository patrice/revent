class Embed < ActiveRecord::Base
  belongs_to :report

  before_create :extract_youtube_video_id
  def extract_youtube_video_id
    uris = URI.extract(html) do |uri|
      next if (uri =~ /youtube.com/).nil?
      match = uri.match /\/v\/(.*)&/
      self.youtube_video_id = match[1] if match
    end
  end

  attr_accessor :tag_depot
end
