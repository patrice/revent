class Event < ActiveRecord::Base
  belongs_to :calendar
  belongs_to :host, :class_name => 'User', :foreign_key => 'host_id'
  has_many :reports, :conditions => "reports.status = '#{Report::PUBLISHED}'", :include => :attachments, :order => 'reports.position', :dependent => :destroy do
    def slideshow?
      !proxy_target.collect {|r| r.attachments}.flatten.empty?
    end
    
    def attachments
      proxy_target.collect {|r| r.attachments}.flatten
    end
  end
#  has_many :attachments, :through => :reports
  has_many :attachments, :dependent => :destroy
  has_many :documents, :class_name => 'Attachment', :conditions => Attachment.types_to_conditions([:document])
  has_many :images, :class_name => 'Attachment', :conditions => Attachment.types_to_conditions([:image])
  has_many :press_links, :through => :reports
  has_many :rsvps, :dependent => :destroy
  has_many :attendees, :through => :rsvps, :source => :user
  has_many :politician_invites

  acts_as_mappable :lat_column_name => 'latitude', :lng_column_name => 'longitude'
  before_validation_on_create :geocode_address
  alias before_validation_on_update before_validation_on_create  
  before_save :set_district
  
  validates_presence_of :name, :description, :location, :city, :state, :postal_code, :directions, :start, :end, :calendar_id
  validates_format_of :postal_code, :with => /^\d{5}(-\d{4})?$/
  #XXX: need to strip out DIA specific language

  has_many :blogs
  
  has_one :democracy_in_action_object, :as => :synced
  def democracy_in_action_synced_table
    'event'
  end

  attr_writer :democracy_in_action
  after_save :sync_to_democracy_in_action
  def sync_to_democracy_in_action
    return unless File.exists?(File.join(Site.current_config_path, 'democracyinaction-config.yml'))

    @democracy_in_action ||= {}
    extra = @democracy_in_action[:event] || {}
    event = self.to_democracy_in_action_event
    extra.each do |key, value|
      event.send "#{key}=", value
    end
    key = event.save
    self.create_democracy_in_action_object :key => key, :table => 'event' unless self.democracy_in_action_object
  end

  before_destroy :delete_from_democracy_in_action
  def delete_from_democracy_in_action
    o = democracy_in_action_object
    api = DemocracyInAction::API.new(DemocracyInAction::Config.new(File.join(Site.current_config_path, 'democracyinaction-config.yml')))
    api.delete 'event', 'key' => self.democracy_in_action_key
    o.destroy
  end

  def to_democracy_in_action_event
    DemocracyInActionEvent.new do |e|
      e.Event_Name  = name
      e.Description = description
      e.Address     = location
      e.City        = city
      e.State       = state
      e.Zip         = postal_code
      e.Start       = "#{self.start.to_s(:db)}.0"
      e.End         = "#{self.end.to_s(:db)}.0"
      e.key         = democracy_in_action_key
      e.event_KEY   = democracy_in_action_key
      e.Latitude    = latitude
      e.Longitude   = longitude
      e.Directions  = directions
      e.supporter_KEY = (self.host ? self.host.democracy_in_action_key : '')
      e.distributed_event_KEY = self.calendar.democracy_in_action_key
    end
  end
  
  def democracy_in_action_key
    democracy_in_action_object.key if democracy_in_action_object
  end

  def address_for_geocode
    [location, city, state, postal_code].compact.join(', ').gsub /\n/, ' '
  end

  alias address address_for_geocode
  
  def set_district
    # get congressional district based on postal code
    dia_warehouse = "http://warehouse.democracyinaction.org/dia/api/warehouse/append.jsp?id=radicaldesigns".freeze
    uri = dia_warehouse + "&postal_code=" + postal_code.to_s
    data = XmlSimple.xml_in(open(uri))
    self.district = data['entry'][0]['district'][0].strip unless data['entry'][0]['district'].nil?
  end
  
  def zip_latitude
    return attributes["zip_latitude"] if attributes["zip_latitude"]
    @zip ||= ZipCode.find_by_zip(postal_code)
    @zip.latitude if @zip
  end

  def zip_longitude
    return attributes["zip_longitude"] if attributes["zip_longitude"]
    @zip ||= ZipCode.find_by_zip(postal_code)
    @zip.longitude if @zip
  end

  def national_map_coordinates
    @zip ||= ZipCode.find_by_zip(postal_code)
    if @zip
      [@zip.latitude, @zip.longitude]
    elsif latitude && longitude
      [latitude, longitude]
    else
      false
    end
  end

  def contact_phone
    if host? && host.phone?
      return host.phone
    else
      return ''
    end
  end

  def past?
    start && start < Time.now
  end

=begin
  class << self
    def find_or_import_by_service_foreign_key(key)
      event = Event.find_by_service_foreign_key(key) || import_by_service_foreign_key(key)
    end

    def import_by_service_foreign_key(key)
      opts = YAML.load_file(File.join(RAILS_ROOT,'config','democracyinaction-config.yml'))
#      require 'DIA_API_Simple'
      require 'democracyinaction'
      api = DIA_API_Simple.new opts
      e = api.get('event', :key => key).first
      return unless e
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
 
    def count_with_reports_published
      find(:all, :include => :reports).select {|e| !e.reports.find_published.empty?}.length
    end
  end
=end

private
  # no longer throwing error if address is not geocodable
  def geocode_address      
    geo=GeoKit::Geocoders::MultiGeocoder.geocode(address_for_geocode)
    self.latitude, self.longitude = geo.lat,geo.lng if geo.success
  end
end
