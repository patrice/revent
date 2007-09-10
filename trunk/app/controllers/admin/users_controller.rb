class Admin::UsersController < AdminController
  def index
    @site_name = Site.current.theme
    @user_pages, @users = paginate(:users, :conditions => ['site_id = ?', Site.current.id], :order => 'last_name', :per_page => 10)
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
      if @user.save
        flash[:notice] = "Password reset for " + @user.full_name
      else
        flash[:notice] = "Could not reset password for " + @user.full_name
      end      
      redirect_to :action => 'index'
    end
  end
end
