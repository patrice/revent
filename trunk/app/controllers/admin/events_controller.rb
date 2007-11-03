class Admin::EventsController < AdminController
  def index
    @calendar = Calendar.find_by_permalink(params[:permalink])
    @events_pages, @events = paginate(:events, :conditions => ['calendar_id = ?', @calendar.id], :order => 'name', :per_page => 50)
  end
  
  def destroy
    e = Event.find(params[:id])
    e.destroy
    # also need to destroy event in DIA
    flash[:notice] = e.name + " has been destroyed"
    redirect_to :action => 'index'
  end
  
  def search
    @events = []
    string = []
    crit = []
    %w(name state city).each do |s|
      string << s + " like ?"
      crit << params[s] + "%"
    end
    event_criteria = [string.join(' AND '), crit].flatten
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
      csv << ["Event Name", "Event ID", "City", "State", "Postal_Code", "District", "High Attendees", "Low Attendees", "Average Attendees"]
      @events.each do |event|
        csv << [event.name, event.id, event.city, event.state, event.postal_code, event.district, event.attendees_high, event.attendees_low, event.attendees_average]
      end
    end
    send_data(string, :type => 'text/csv; charset=utf-8; header=present', :filename => "events.csv")
  end  

  def featured_images
    collect_featured_images
    image_names = []
    timestamp = Time.now.strftime("%y%m%d_%H%M%S") 
    image_dir = File.join(RAILS_ROOT, 'public', 'featured_images_' + timestamp)
    result = `mkdir #{image_dir}` if not File.exists?(image_dir)
    @featured_images.each do |a|
      local_filename = File.join(image_dir, a.report.event.state + "_" + a.report.event.id.to_s + File.extname(a.public_filename))
      result = `curl #{a.public_filename} > #{local_filename}`
      image_names << local_filename
    end
    image_names = image_names.join(' ')
    result = `zip #{File.join(RAILS_ROOT,'public','featured_images_' + timestamp + '.zip')} #{image_names}`
    render :inline => "generated zip successfully, please download it <%= link_to 'here', '/featured_images.zip' %>"
#    send_data result, :filename => 'featured_images.zip'
  end

  def mail_merge
    @calendar = Calendar.find_by_permalink(params[:permalink])
    render :layout => false
  end

private  
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
