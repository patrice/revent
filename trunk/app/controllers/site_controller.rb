class SiteController < ApplicationController
  before_filter :login_required
  access_control :DEFAULT => 'admin'

  def load_data
    case params[:id]
    when 'test'
      require 'active_record/fixtures'
        ['calendars.yml', 'events.yml', 'reports.yml'].each do |fixture_file| Fixtures.create_fixtures(File.join('test','fixtures'), File.basename(fixture_file, '.*'))
      end
    when 'dia'
      opts = YAML.load_file(File.join(RAILS_ROOT,'config','democracyinaction-config.yml'))
      require 'DIA_API_Simple'
      api = DIA_API_Simple.new opts
      events = api.get('event')
      flash[:notice] = events.length.to_s + " events added from DIA"

      gmaps = Cartographer::Header.new
      if gmaps.has_key? request.env["HTTP_HOST"] #+ uri
        application_id = gmaps.value_for request.env["HTTP_HOST"] #+ uri
        require 'google_geocode'
        gg = GoogleGeocode::Accuracy.new application_id
      else
        raise 'wtf'
      end

      unknown = inaccurate = 0
      events.each do |e|
        my_event = Event.find_or_create_by_service_foreign_key(e['event_KEY'])
        my_event.calendar_id=1
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
          if location.accuracy.to_i < 8
            inaccurate = inaccurate + 1
          else
            my_event.latitude = location.latitude
            my_event.longitude = location.longitude
          end
        rescue GoogleGeocode::AddressError => error
          unknown = unknown + 1
        end

        my_event.save!
      end
    end
    flash[:notice] = "#{events.length} events imported, #{events.length - unknown - inaccurate} geocoded; of the rest, #{unknown} google could not geocode, #{inaccurate} geocoded with too low a degree of accuracy"
    redirect_to '/admin/events'
  end
end
