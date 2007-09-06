class Admin::UsersController < AdminController
  def index
    @site_name = Site.current.theme
    @user_pages, @users = paginate(:users, :conditions => ['site_id = ?', Site.current.id], :order => 'last_name', :per_page => 10)
  end
  
  def search
    @user = User.find_by_email(params[:email])
    if @user.nil?
      flash.now[:notice] = "Could not find a user with that email address"
      index && render(:action => 'index') and return
    end
  end
  
  def reset_password
    @user = User.find(params[:id])
    if request.post?      
      @user.password = params[:user][:password] if params[:user][:password]
      @user.password_confirmation = params[:user][:password_confirmation] if params[:user][:password_confirmation]
      if (@user.save)
        flash.now[:notice] = "Password reset for " + @user.full_name
        index and render(:action => 'index') and return
      else
        flash.now[:notice] = "Password not reset for " + @user.full_name
      end      
    end
  end
end
