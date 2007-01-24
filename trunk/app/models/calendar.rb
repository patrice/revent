class Calendar < ActiveRecord::Base
  has_many :events

  #XXX:DELETEME mock methods
  def national_intro_text
    'national intro text'
  end

  def national_footer_text
    'national footer text'
  end

  DiaLoadResult = Struct.new(:imported, :unknown, :inaccurate)
  def self.load_from_dia(id, *args)
    cal = find(id)
    return unless cal
    options = args.last.is_a?(Hash) ? args.pop : {}
    opts = YAML.load_file(File.join(RAILS_ROOT,'config','democracyinaction-config.yml'))
    require 'DIA_API_Simple'
    api = DIA_API_Simple.new opts
    events = api.get('event')
    gmaps = Cartographer::Header.new
    if gmaps.has_key? options[:host]
      application_id = gmaps.value_for options[:host]
      require 'google_geocode'
      gg = GoogleGeocode::Accuracy.new application_id
    else
      raise 'wtf'
    end

    result = DiaLoadResult.new 0, 0, 0
    events.each do |e|
      my_event = Event.find_or_create_by_service_foreign_key(e['event_KEY'])
      my_event.calendar_id = id
      my_event.name = e['Event_Name']
      my_event.description = e['Description']
      my_event.location = e['Address']
      my_event.city = e['City']
      my_event.state = e['State']
      my_event.postal_code = e['Zip']
      my_event.start = e['Start']
      my_event.end = e['End']
      my_event.directions = e['Directions']

      begin
        location = gg.locate my_event.address_for_geocode
        if location.accuracy.to_i < 7
          result.inaccurate = result.inaccurate + 1
        else
          my_event.latitude = location.latitude
          my_event.longitude = location.longitude
        end
      rescue GoogleGeocode::AddressError => error
        result.unknown = result.unknown + 1
      end

      my_event.save!
    end
    result.imported = events.length
    return result
  end
end
