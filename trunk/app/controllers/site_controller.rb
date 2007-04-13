class SiteController < ApplicationController
  before_filter :login_required, :except => :map
  access_control :DEFAULT => 'admin'

  def write_update_migration
    return false
    events = Event.find(:all, :conditions => "district IS NOT NULL AND person_legislator_ids IS NOT NULL")
    File.open(File.join(RAILS_ROOT,'db','migrate','districts_and_legislators.sql'), 'w') do |file|
      events.each do |event|
        file << "UPDATE events SET `district` = '#{event.district}', `person_legislator_ids` = '#{event.person_legislator_ids}' WHERE `service_foreign_key` = '#{event.description}';\n"
      end
    end
    render :text => 'success'
  end

  def update_campaigns
    campaign = DemocracyInActionCampaign.find(7199)

    events = Event.find(:all, :conditions => "district IS NOT NULL AND person_legislator_ids IS NOT NULL AND campaign_key IS NULL")

    html = ""
    events.each do |event|
      @event = event
      new_campaign = campaign.clone
      new_campaign.key = nil
      new_campaign.campaign_KEY = nil

      new_campaign.Suggested_Subject = render_to_string(:template => "reports/action/subject", :layout => false)
      new_campaign.person_legislator_IDS = @event.person_legislator_ids
      new_campaign.Suggested_Content = render_to_string(:template => "reports/action/action", :layout => false)
      new_campaign.Spread_The_Word_Text = render_to_string(:template => "reports/action/spread_word", :layout => false)
      new_campaign.Reference_Name = "#{@event.service_foreign_key}: #{@event.city}, #{@event.state}"
    
      new_campaign.save
      @event.update_attribute(:campaign_key, new_campaign.key)
      html << "added campaign: #{new_campaign.key}<br/>"
    end
    render :text => html, :layout => false
  end

  def update_districts
    events = Event.find(:all, :conditions => {:district => nil, :person_legislator_ids => nil})

    api = DIA_API_Simple.new "authCodes" => ["jwarnow@gmail.com", "80by50", 1879]
    remote_events = api.get 'event', 'column' => 'supporter_KEY,Zip,State', 'key' => events.collect {|e| e.service_foreign_key}.compact
    hosts = api.get 'supporter', 'key' => remote_events.collect {|e| e['supporter_KEY']}, 'column' => 'District'

    html = ""
    require 'open-uri'
    remote_events.each do |event|
      
      host = hosts.detect {|h| h['supporter_KEY'] == event['supporter_KEY']}
      html << "no host for event #{event['event_KEY']}<br/><br/>" and next unless host

      district = nil
      if host['District'] && host['District'] != 'N/A'
        district = host['District'].strip
      else
        html << "no zip for event #{event['event_KEY']}<br/><br/>" and next unless event['Zip']
        begin
          xml = open("http://warehouse.democracyinaction.org/dia/api/warehouse/append.jsp?id=hi-chris-this-is-seth-from-radical-designs-stop-locking-me-out&postal_code=#{event['Zip']}")
          if xml.is_a?(Tempfile)
            xml = xml.read
          end
          data = XmlSimple.xml_in(xml)
          next if data.empty?
        rescue 
          html << "got an error trying to open warehouse with zip: #{event['Zip']}<br/><br/>"
          next
        end
        district = data['entry'][0]['district'][0].strip if data['entry'][0]['district']
      end
      html << "no district for event #{event['event_KEY']}!<br/><br/>" and next unless district

      congress = []

      data = XmlSimple.xml_in(open("http://warehouse.democracyinaction.org/dia/api/warehouse/legislator.jsp?method=getLegislatorFromDistrict&district=#{district}&district_type=FH"))
      html << "error for event #{event['event_KEY']}: #{data['error'][0]}<br/><br/>" and next if data['error']
      congress << data['legislator'][0]['person_legislator_ID'][0]

      data = XmlSimple.xml_in(open("http://warehouse.democracyinaction.org/dia/api/warehouse/legislator.jsp?method=getLegislatorFromDistrict&district=#{event['State']}1&district_type=FS"))
      html << "error for event #{event['event_KEY']}: #{data['error'][0]}<br/><br/>" and next if data['error']
      congress << data['legislator'][0]['person_legislator_ID'][0] unless data.blank?

      data = XmlSimple.xml_in(open("http://warehouse.democracyinaction.org/dia/api/warehouse/legislator.jsp?method=getLegislatorFromDistrict&district=#{event['State']}2&district_type=FS"))
      html << "error for event #{event['event_KEY']}: #{data['error'][0]}<br/><br/>" and next if data['error']
      congress << data['legislator'][0]['person_legislator_ID'][0] unless data.blank?

      e = events.detect {|local_event| event['event_KEY'] == local_event.service_foreign_key}
      e.district = district
      e.person_legislator_ids = congress.compact.join(',')
      e.perform_remote_update = false
      e.save_with_validation(false)
      html << "updating event with DIA key #{event['event_KEY']} with:<br/>district: '#{district}'<br/>person_legislator_ids: '#{congress.compact.join(',')}'<br/><br/>"
    end

    render :text => html
  end

  def map
    require 'RMagick'
    image = Magick::Image.read(File.join(RAILS_ROOT,'lib','fresh.png')).first
    width = image.columns
    height = image.rows
    gc = Magick::Draw.new
    gc.fill "#75AD50"
    events = Event.find(:all)
    coords = events.collect {|e| e.national_map_coordinates}.select do |c|
      c && c[0].nonzero? && c[1].nonzero? &&
        (24.520833..49.384472).include?(c[0]) &&
        (-124.736611..-66.950556).include?(c[1])
    end
    gxf = 8.9
    gyf = 11.55
    gxs = 56.4
    gys = 23.9
    coords.each do |c|
      y     = (height - (-gys + c[0]) * gyf).round
      rat   = (height - y) / height
      gxfa  = gxf - (rat * 1.13)
      gxsa  = gxs - (rat * 5.77)
      x     = (width + ((gxsa + c[1])*gxfa)).round
      gc.circle x+5, y-5, x+10, y-5
    end
    gc.draw image
    send_data image.to_blob, :type => image.mime_type, :disposition => 'inline'
  end

  def load_data
    case params[:id]
    when 'test'
      require 'active_record/fixtures'
      ['calendars.yml', 'events.yml', 'reports.yml'].each do |fixture_file| 
        Fixtures.create_fixtures(File.join('test','fixtures'), File.basename(fixture_file, '.*'))
      end
      flash[:notice] = "Test fixtures loaded"
    when 'dia'
      result = Calendar.load_from_dia(1, :host => request.env["HTTP_HOST"])
      flash[:notice] = "#{result.imported} events imported, #{result.imported - result.unknown - result.inaccurate} geocoded; of the rest, #{result.unknown} google could not geocode, #{result.inaccurate} geocoded with too low a degree of accuracy"
      expire_page_caches
    end
    redirect_to '/admin/events'
  end
  protected
    def expire_page_caches(event = nil)
      expire_action :controller => 'events', :action => 'ally'
      FileUtils.rm_rf(File.join(RAILS_ROOT,'public','events')) rescue Errno::ENOENT
      FileUtils.rm(File.join(RAILS_ROOT,'public','index.html')) rescue Errno::ENOENT
      RAILS_DEFAULT_LOGGER.info("Caches fully swept.")
    end
end
