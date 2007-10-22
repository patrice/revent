class Admin::UsersController < AdminController
  def index
    @site_name = Site.current.theme
    @user_pages, @users = paginate(:users, :conditions => ['site_id = ?', Site.current.id], :order => 'last_name', :per_page => 10)
  end
  
  
  active_scaffold :users do |config|
 	config.list.columns = [:first_name, :last_name, :email, :roles, :events, :site]
	config.columns = [:first_name, :last_name, :email, :roles, :site]
 	columns[:roles].ui_type = :select
 	columns[:site].ui_type = :select
 	config.action_links.add 'reset_password', :label => 'Reset Password', :type => :record, :page => true
 	
  end
  
  
  
  def search
    @users = []
    @users = User.find(:all, :conditions => ['site_id = ? AND email like ?', Site.current.id, params[:email] + "%"])
    if @users.empty?
      flash[:notice] = "Could not find a user with that email address."
      redirect_to :action => 'index'
    end
  end
  
  def reset_password
    @user = User.find(params[:id])
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
    @users = User.find(:all, :conditions => ['site_id = ?', Site.current.id])
    require 'fastercsv'
    string = FasterCSV.generate do |csv|
      csv << ["Email", "First_Name", "Last_Name", "Phone", "Street", "Street_2", "City", "State", "Postal_Code"]
      @users.each do |user|
        csv << [user.email, user.first_name, user.last_name, user.phone, user.street, user.street_2, user.city, user.state, user.postal_code]
      end
    end
    send_data(string, :type => 'text/csv; charset=utf-8; header=present', :filename => "users.csv")
  end
end
