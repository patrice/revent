class SiteController < ApplicationController
  before_filter :login_required, :only => :load_data
  access_control :load_data => 'admin'

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
