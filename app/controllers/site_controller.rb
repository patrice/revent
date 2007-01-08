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
      require 'DIA_API'
      api = DIA_API_Simple.new opts
      events = api.get('event')
      flash[:notice] = events.length.to_s + " events added from DIA"
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
        my_event.latitude = e['Latitude']
        my_event.longitude = e['Longitude']
        my_event.save!
      end
    end
    redirect_to home_url
  end
end
