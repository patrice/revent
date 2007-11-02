class PressLink < ActiveRecord::Base
  belongs_to :report
  
  def validate 
    begin
      URI.parse(self.url)
    rescue URI::InvalidURIError
      errors.add(:url, 'The format of the URL is not valid.')
    end
  end
  
  def before_save
    # add 'http://' at beginning of url if not there
    if not self.url =~ /^https?:\/\/.*/
      self.url = "http://" + self.url
    end
  end
end

