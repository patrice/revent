class Calendar < ActiveRecord::Base
  @@deleted_events = []
  @@all_events = []

  has_many :events do
    def unique_states
      states = proxy_target.collect {|e| e.state}.compact.uniq.select do |state|
        DaysOfAction::Geo::STATE_CENTERS.keys.reject {|c| :DC == c}.map{|c| c.to_s}.include?(state)
      end
      states.length
    end
  end

  def self.clear_deleted_events
    find_deleted_events
    @@deleted_events.each do |e|
      e.destroy
    end
    if !@@deleted_events.empty?
      FileUtils.rm_rf(File.join(RAILS_ROOT,'public','events')) rescue Errno::ENOENT
      FileUtils.rm(File.join(RAILS_ROOT,'public','index.html')) rescue Errno::ENOENT
      RAILS_DEFAULT_LOGGER.info("Caches fully swept after deleting #{@@deleted_events.length} events")
    end
  end

  def self.find_deleted_events
    @@all_events = Event.find(:all)
    opts = YAML.load_file(File.join(RAILS_ROOT,'config','democracyinaction-config.yml'))
    require 'DIA_API_Simple'
    api = DIA_API_Simple.new opts
    @@all_events.each do |e|
      dia_event = api.get 'event', e.service_foreign_key
      @@deleted_events << e if dia_event.empty?
    end
    @@deleted_events
  end

  DiaLoadResult = Struct.new(:imported, :unknown, :inaccurate)
  def self.load_from_dia(id, *args)
    cal = find(id)
    return unless cal
    options = args.last.is_a?(Hash) ? args.pop : {}
    opts = YAML.load_file(File.join(RAILS_ROOT,'config','democracyinaction-config.yml'))
    require 'DIA_API_Simple'
    api = DIA_API_Simple.new opts
    events = api.get('event', options[:options_for_dia] || {})
    gmaps = Cartographer::Header.new
    if gmaps.has_key? options[:host]
      application_id = gmaps.value_for options[:host]
      require 'google_geocode'
      gg = GoogleGeocode::Accuracy.new application_id
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

      if gg
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
      end

      my_event.save!
    end
    result.imported = events.length
    if !events.empty?
      FileUtils.rm_rf(Dir.glob(File.join(RAILS_ROOT,'tmp','cache','*')))
      FileUtils.rm_rf(File.join(RAILS_ROOT,'public','events')) rescue Errno::ENOENT
      FileUtils.rm(File.join(RAILS_ROOT,'public','index.html')) rescue Errno::ENOENT
      RAILS_DEFAULT_LOGGER.info("Caches fully swept after adding #{events.length} events")
    end
    return result
  end
end
