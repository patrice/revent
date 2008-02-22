class Admin::UsersController < AdminController  
  active_scaffold :users do |config|
    config.label = "Site Users"
    config.columns.add :effective_calendar
  	config.columns = config.list.columns = [:created_at, :effective_calendar, :first_name, :last_name, :email, :state, :city, :events, :attending, :site]
  	columns[:effective_calendar].sort_by :method => 'effective_calendar.name'
  	config.update.columns = [:first_name, :last_name, :email , :site ]
  	config.columns[:created_at].label = "Created on"
  	config.columns[:events].label = "Hosting"
   	columns[:site].form_ui = :select
   	config.action_links.add 'reset_password', :label => 'Reset Password', :type => :record, :page => true
    config.columns[:events].clear_link
    config.list.sorting = [{ :created_at => :desc }]
  end

  # need this to provide export users link
  def index
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
    @users = Site.current.users
    require 'fastercsv'
    string = FasterCSV.generate do |csv|
      csv << ["Email", "First_Name", "Last_Name", "Phone", "Street", "Street_2", "City", "State", "Postal_Code"]
      @users.each do |user|
        csv << [user.email, user.first_name, user.last_name, user.phone, user.street, user.street_2, user.city, user.state, user.postal_code]
      end
    end
    send_data(string, :type => 'text/csv; charset=utf-8; header=present', :filename => "#{Site.current.theme}_users.csv")
  end
end
