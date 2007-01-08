class Event < ActiveRecord::Base
  belongs_to :calendar
  belongs_to :host, :class_name => 'User', :foreign_key => 'host_id'
  has_many :reports, :order => 'position'
  has_many :rsvps
  has_many :attendees, :through => 'rsvps', :source => :user
  has_many :attachments, :through => 'attachables'

  def contact_phone
    if host? && host.phone?
      return host.phone
    else
      return ''
    end
  end
end
