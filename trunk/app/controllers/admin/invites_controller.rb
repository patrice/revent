class Admin::InvitesController < AdminController 
 
  def all
    @politicians = Politician.find(:all, :include => [:rsvps, :politician_invites]) 
    @select_events = @calendar.events.find(:all).map{|e| [e.name, e.id]}
    render :action => :index
  end

  def index
    @politicians = Candidate.find(:all, :include => [:rsvps, :politician_invites], :conditions => ['office = ?', 'president'])
    @select_events = @calendar.events.find(:all).map{|e| [e.name, e.id]}
  end
  
  def search
    fields = [] 
    values = []
    fields << "(first_name like ? OR last_name like ? OR display_name like ?)"
    3.times {values << params[:name] + "%"}
    fields << "state like ?" 
    values << params[:state].downcase + "%" 
    query = [fields.join(' AND '), values].flatten
    @politicians = Politician.find(:all, :conditions => query, :order => "district_type DESC")
    @events = @calendar.events.find(:all, :select => "name, id", :order => "name")
    @select_events = []
    @events.each {|e| @select_events << [e.name, e.id]}
    render :action => 'index'
  end 

  def new 
    @candidate = Candidate.new(params[:candidate])
    if request.post?
      @candidate.display_name = @candidate.first_name + ' ' + @candidate.last_name
      @candidate.save
      flash[:notice] = 'New candidate has been added!'
      redirect_to :action => 'index'
    end
  end 

  def edit
    @politician = Politician.find(params[:id])
    if request.post?
      p = @politician
      p.display_name.gsub!(p.first_name, params[:politician][:first_name]) if params[:politician][:first_name]
      p.display_name.gsub!(p.last_name, params[:politician][:last_name]) if params[:politician][:last_name]
      p.update_attributes(params[:politician]) 
      flash[:notice] = 'Politician information has been updated!'
      redirect_to :action => 'index'
    end
  end
  
  def confirm
    @politician = Politician.find(params[:id])
    r = @politician.rsvps.build(:event_id => params[:event])
    r.save
    redirect_to :action => 'index'
  end
  
  def unconfirm
    @politician = Politician.find(params[:id])
    @rsvp = Rsvp.find(params[:rsvp])
    @politician.rsvps.delete(@rsvp)
    redirect_to :action => 'index'
  end
end

