class EventGroup < ActiveRecord::Base
  has_many :events

  #XXX:DELETEME mock methods
  def national_intro_text
    'national intro text'
  end

  def national_footer_text
    'national footer text'
  end
end
