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
  has_many :rsvpd_politicians, :through => :rsvps, :source => :attending, :source_type => 'Politician'
  has_many :attending_politicians, :through => :rsvps, :source => :attending, 
      :source_type => 'Politician', :conditions => '(rsvps.proxy IS NULL) OR (NOT rsvps.proxy)'
  has_many :supporting_politicians, :through => :rsvps, :source => :attending, 
      :source_type => 'Politician', :conditions => '(rsvps.proxy IS NOT NULL) AND (rsvps.proxy)'
  has_many :politician_invites

  belongs_to :category

  acts_as_mappable :lat_column_name => 'latitude', :lng_column_name => 'longitude'
  before_validation :geocode
  before_save :set_district
  
  validates_presence_of :name, :description, :location, :city, :state, :postal_code, :directions, :start, :end, :calendar_id
  # second part of this regular expression checks for Canadian postal codes
  validates_format_of :postal_code, :with => /(^\d{5}(-\d{4})?$)|(^\D\d\D((-| )?\d\D\d)?$)/ # 

  def validate
    if event_start = self.calendar.event_start
      if event_end = self.calendar.event_end
        if self.start && self.start < event_start.at_beginning_of_day
          message = event_start.to_date == event_end.to_date ? "on" : "on or after"
          errors.add :start, "must be #{message} #{event_start.strftime('%B %e, %Y')}"
        end
        if self.end && self.end > (event_end + 1.day).at_beginning_of_day
          message = event_start.to_date == event_end.to_date ? "on" : "on or before"
          errors.add :end, "must be #{message} #{event_end.strftime('%B %e, %Y')}"
        end
      else
        unless self.start.to_date == event_start.to_date
          errors.add :start, "must be on #{event_start.strftime('%B %e, %Y')}"
        end
      end
    end    
    unless (self.latitude and self.longitude) or (self.fallback_latitude and self.fallback_longitude)
      errors.add_to_base "Not enough information provided to place event on a map. Please give us at least a valid postal code."
    end
  end
  #XXX: need to strip out DIA specific language

  has_many :blogs
  
  has_many :democracy_in_action_campaigns, :as => :associated, :class_name => 'DemocracyInActionObject', :conditions => "democracy_in_action_objects.table = 'campaign'"
  def campaign_for_politician(politician)
    democracy_in_action_campaigns.each do |c|
      if c.local 
        legislator_ids = c.local.person_legislator_IDS.split(',').collect {|id| id.strip} if c.local.person_legislator_IDS
        recipient_keys = c.local.recipient_KEYS.split(',').collect {|key| key.strip} if c.local.recipient_KEYS
        if (legislator_ids && legislator_ids.include?(politician.person_legislator_id.to_s)) || (recipient_keys && recipient_keys.include?(politician.democracy_in_action_recipient_key.to_s))
          return c.local
        end
      end
    end
    nil
  end

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
    # don't lookup us congressional district for non-us postal_codes
    return unless postal_code =~ /^\d{5}(-\d{4})?$/
    
    # get congressional district based on postal code
    dia_warehouse = "http://warehouse.democracyinaction.org/dia/api/warehouse/append.jsp?id=radicaldesigns".freeze
    uri = dia_warehouse + "&postal_code=" + postal_code.to_s
    data = XmlSimple.xml_in(open(uri))
    unless data['entry'][0]['district'].nil? || (self.district && data['entry'][0]['district'].map {|d| d.strip}.include?(self.district))
      self.district = data['entry'][0]['district'][0].strip 
    end
  end

# zip_latitude & zip_longitude superseded by fallback_latitude & fallback_longitude
=begin
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
=end

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

  def attendees_high
    rprts = reports.reject{|r| not r.attendees or r.attendees <= 0}
    return nil if rprts.empty?
    rprts.map{|r| r.attendees}.max
  end
  
  def attendees_low
    rprts = reports.reject{|r| not r.attendees or r.attendees <= 0}
    return nil if rprts.empty?
    rprts.map{|r| r.attendees}.min
  end
  
  def attendees_average
    rprts = reports.reject{|r| not r.attendees or r.attendees <= 0}
    return nil if rprts.empty?
    rprts.map{|r| r.attendees}.sum / rprts.length
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
  def geocode
    if (geo = GeoKit::Geocoders::MultiGeocoder.geocode(address_for_geocode)).success
      self.latitude, self.longitude = geo.lat, geo.lng
    elsif (geo = GeoKit::Geocoders::MultiGeocoder.geocode(self.postal_code)).success 
      self.fallback_latitude, self.fallback_longitude = geo.lat, geo.lng
    elsif (geo = GeoKit::Geocoders::MultiGeocoder.geocode([self.city, self.state].join(', '))).success
      self.fallback_latitude, self.fallback_longitude = geo.lat, geo.lng
    end
  end
end
