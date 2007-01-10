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

  class << self
    def find_or_import_by_service_foreign_key(key)
      event = Event.find_by_service_foreign_key(key) || import_by_service_foreign_key(key)
    end

    def import_by_service_foreign_key(key)
      opts = YAML.load_file(File.join(RAILS_ROOT,'config','democracyinaction-config.yml'))
      require 'DIA_API_Simple'
      api = DIA_API_Simple.new opts
      e = api.get('event', :key => key).first
      Event.create(:service_foreign_key => e['event_KEY'],
                   :calendar_id => 1,
                   :name => e['Event_Name'],
                   :description => e['Description'],
                   :city => e['City'],
                   :state => e['State'],
                   :postal_code => e['Zip'],
                   :start => e['Start'],
                   :end => e['End'],
                   :latitude => e['Latitude'],
                   :longitude => e['Longitude'])
    end

    def count_with_reports
      find(:all, :include => :reports).select {|e| !e.reports.empty?}.length
    end
  end
end
