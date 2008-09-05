class Admin::UsersController < AdminController  
  active_scaffold :users do |config|
    config.columns.add :effective_calendar
  	config.list.columns = 
  	    [:created_at, :email, :first_name, :last_name, :city, :state, :events, :attending, :effective_calendar, :site]
  	config.show.columns = 
  	    [:created_at, :email, :first_name, :last_name, :phone, :street, :street_2, :city, :state, :postal_code]
  	config.update.columns =     
  	    [:email, :first_name, :last_name, :phone, :street, :street_2, :city, :state, :postal_code]
    config.actions.exclude :create
   	config.action_links.add 'reset_password', :label => 'Reset Password', :type => :record, :page => true
    config.list.sorting = [{ :created_at => :desc }]
  	config.columns[:created_at].label = "Created on"
  	config.columns[:events].label = "Hosting"
  	config.columns[:events].clear_link
    config.columns[:attending].clear_link    
  	columns[:effective_calendar].sort_by :method => 'effective_calendar.name'
=begin
    config.columns[:attending].set_link('nested', :parameters => {:associations => :attending})
    config.columns[:events].set_link('nested', :parameters => {:associations => :events})
=end
  end
  
  def index
    # embed active_scaffold in index.rhtml so we can provide export users link
  end 
  
  def reset_password
    @user = Site.current.users.find(params[:id])
    if request.post?      
      @user.password = params[:user][:password] if params[:user][:password]
      @user.password_confirmation = params[:user][:password_confirmation] if params[:user][:password_confirmation]
      @user.activated_at = Time.now.utc
      if @user.save
        flash[:notice] = "Password reset for " + @user.full_name
      else
        flash[:notice] = "Could not reset password for " + @user.full_name
      end      
      redirect_to :action => 'index'
    end
  end

  def export
    @users = Site.current.users.find(:all, :include => :custom_attributes)
    @attribute_names = @users.inject([]) {|names, u| names << u.custom_attributes.map {|a| a.name }; names.flatten.compact.uniq }
    require 'fastercsv'
    string = FasterCSV.generate do |csv|
      csv << ["Email", "First_Name", "Last_Name", "Phone", "Street", "Street_2", "City", "State", "Postal_Code", "Partner_Code", "Events_Hosting_IDS", "Events_Attending_IDS"] + @attribute_names
      @users.each do |user|
        csv << [user.email, user.first_name, user.last_name, user.phone, user.street, user.street_2, user.city, user.state, user.postal_code, user.partner_id] + [ user.event_ids.join(','), user.attending_ids.join(',') ] + @attribute_names.map {|a| user.custom_attributes_data.send(a.to_sym) }
      end
    end
    send_data(string, :type => 'text/csv; charset=utf-8; header=present', :filename => "#{Site.current.theme}_users.csv")
  end
end
