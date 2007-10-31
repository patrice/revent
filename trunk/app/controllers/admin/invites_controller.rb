class Admin::InvitesController < AdminController 
 
  def all
    @politicians = Politician.find(:all, :include => [:rsvps, :politician_invites]) 
    @select_events = @calendar.events.find(:all).map{|e| [e.name, e.id]}
    render :action => :index
  end

  def index
    redirect_to :action => 'list', :id => 'president'
  end
    
  def list
    if params[:id] == 'all'
      @politicians = Politician.find(:all, :include => [:rsvps, :politician_invites]).sort_by {|p| p.politician_invites.length}.reverse
    elsif params[:id] == 'congress'
      @politicians = Candidate.find(:all, :conditions => "office = 'representative' or office = 'senator'", :include => [:rsvps, :politician_invites]).sort_by {|p| p.politician_invites.length}.reverse
    else 
      @politicians = Candidate.find_all_by_office(params[:id], :include => [:rsvps, :politician_invites]).sort_by {|p| p.politician_invites.length}.reverse
    end
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
    @politicians = Politician.find(:all, :conditions => query, :order => "district_type DESC, district ASC")
    @events = @calendar.events.find(:all, :select => "name, id", :order => "name")
    @select_events = []
    @events.each {|e| @select_events << [e.name, e.id]}
    render :action => 'list'
  end 
  
  def new 
    @politician = Candidate.new(params[:politician])
  end
  
  def create
    @politician = Candidate.new(params[:politician])
    if @politician.save
      flash[:notice] = 'New candidate has been added!'
      redirect_to :action => 'index' and return
    else 
      render :action => 'new'
    end
  end

  def edit
    @politician = Politician.find(params[:id])
    @district_number = @politician.district.slice(2..3).to_i if @politician.district
    unless @politician.office
      @politician.office = case @politician.district_type
        when "FS": "senator"
        when "FH": "representative"
      end
    end
  end

  def update
    @politician = Politician.find(params[:id])
    @district_number = @politician.district.slice(2..3).to_i if @politician.district
    if @politician.update_attributes(params[:politician])
      flash[:notice] = 'Politician information has been updated!'
      redirect_to :action => 'index' and return
    else
      render :action => 'edit'
    end
  end 
  
  def destroy
    Politician.destroy(params[:id])
    flash[:notice] = "Politician has been deleted!"
    redirect_to :action => 'index'
  end

  def confirm
    @politician = Politician.find(params[:id])
    r = @politician.rsvps.build(:event_id => params[:event], :proxy => params[:proxy])
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

