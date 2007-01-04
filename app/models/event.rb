class Event < ActiveRecord::Base
  belongs_to :event_group
  belongs_to :host, :class_name => 'User', :foreign_key => 'host_id'
  has_many :reports, :order => 'position'
  has_many :rsvps
  has_many :attendees, :through => 'rsvps', :source => :person
  has_many :medias
end
