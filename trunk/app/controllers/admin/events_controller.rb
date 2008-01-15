class Admin::EventsController < AdminController
  def index
    @calendar = Calendar.find_by_permalink(params[:permalink])
    cookies[:permalink] = params[:permalink]
    @events = Event.paginate(:conditions => ['calendar_id = ?', @calendar.id], :order => 'name', :page => params[:page])
  end
  
  def destroy
    e = Event.find(params[:id])
    e.destroy
    # also need to destroy event in DIA
    flash[:notice] = e.name + " has been destroyed"
    redirect_to :action => 'index'
  end
  
  def search
    @events, sql, crit = [], [], []
    %w(name state city).each do |att|
      sql << att + " like ?"
      crit << params[att] + "%"
    end
    event_criteria = [sql.join(' AND '), crit].flatten
    @events = @calendar.events.find(:all, :conditions => event_criteria)
    if @events.empty?
      flash[:notice] = "Could not find that event."
      redirect_to :action => 'index'
    end
  end

  def nomap
    @events = @calendar.events.find(:all, :conditions => "latitude = 0 or latitude IS NULL or longitude = 0 or longitude IS NULL")
    render :action => 'search'
  end
  
  def export
    @events = @calendar.events.find(:all, :include => :reports)
    require 'fastercsv'
    string = FasterCSV.generate do |csv|
      csv << ["Event ID", "Event Name", "City", "State", "Postal_Code", "District", 
              "Host Name", "Host Email", "Host Phone", "Host Address", 
              "High Attendees", "Low Attendees", "Average Attendees"]
      @events.each do |event|
        host = event.host
        csv << [event.id, event.name, event.city, event.state, event.postal_code, event.district,
                (host ? host.full_name : nil), (host ? host.email : nil), 
                (host ? host.phone : nil), (host ? host.address : nil),
                event.attendees_high, event.attendees_low, event.attendees_average]
      end
    end
    send_data(string, :type => 'text/csv; charset=utf-8; header=present', :filename => "events.csv")
  end  

  def featured_images
    collect_featured_images
    require 'starling_client'
    queue = Starling.new 'localhost:22122'
    timestamp = Time.now.strftime("%y%m%d_%H%M%S") 
    @latest = File.join(RAILS_ROOT,'public','featured_images_' + timestamp + '.zip')
    queue.set 'images', {:timestamp => timestamp, :images => @featured_images, :site => Site.current}

#    render :inline => "generated zip successfully, please download it <%= link_to 'here', '/#{zip_file_name}' %>"
#    send_data result, :filename => 'featured_images.zip'
  end

  def mail_merge
    @calendar = Calendar.find_by_permalink(params[:permalink])
    render :layout => false
  end

private  
  def zip_em_up(timestamp)
    image_names = []
    image_dir = File.join(RAILS_ROOT, 'public', 'featured_images_' + timestamp)
    result = `mkdir #{image_dir}` if not File.exists?(image_dir)
    @featured_images.each do |a|
      local_filename = File.join(image_dir, a.report.event.state + "_" + a.report.event.id.to_s + File.extname(a.public_filename))
      next if Dir[File.join(RAILS_ROOT, 'public', 'featured_images*', '*')].map {|full_path| File.basename(full_path)}.include?(File.basename(local_filename))
      result = `curl #{a.public_filename} > #{local_filename}`
      image_names << local_filename
    end
    return if image_names.empty?
    image_names = image_names.join(' ')
    @latest = File.join(RAILS_ROOT,'public','featured_images_' + timestamp + '.zip')
    result = `zip -j #{@latest} #{image_names}`
  end

  def collect_featured_images
    events = @calendar.events.find(:all, :include => {:reports => :attachments}, :conditions => "attachments.id")
    @featured_images = []
    events.each do |e|
      next unless e.reports
      attachments = e.reports.collect {|r| r.attachments}.flatten.sort_by {|a| a.primary ? 1 : 0}
      next if attachments.empty?
      primary = attachments.first if attachments.first.primary
      primary ||= e.reports.first.attachments.first
      primary ||= attachments.first
      @featured_images << primary
    end
#    send_data `zip -j - #{package.collect {|a| a.full_filename}.join(' ')}`, :filename => 'featured_images.zip'
  end

end
