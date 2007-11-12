class AdminController < ApplicationController
  before_filter :login_required, :except => 'login'
  before_filter :instantiate_controller_and_action_names

  def login
    return unless request.post?
    self.current_user = User.authenticate(params[:email], params[:password])
    if current_user
      if params[:remember_me] == "1" && current_user.respond_to?(:remember_me)
        self.current_user.remember_me
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
#      redirect_back_or_default(:controller => '/account', :action => 'profile')
      redirect_back_or_default(:controller => '/admin', :action => 'index')
      flash[:notice] = "Logged in successfully"
    else
      flash[:notice] = "Login failed"
    end
  end

  def instantiate_controller_and_action_names
    @current_action = action_name
    @current_controller = controller_path
  end
  
  def set_calendar
    @calendor = super
    #admin version checks for a cookie to specify the working calendar
    @most_recent_calendar = site.calendars.detect {|calendar| params[:permalink] == calendar.permalink } || site.calendars.detect {|calendar| cookies[:permalink] == calendar.permalink } || site.calendars.current || site.calendars.first    
    @calendar
  end

protected
  def authorized?
    if current_user.admin?
      #flash[:notice] = "You are an admin"
      return true
    end
    flash[:notice] = "Must be an administrator to access this section"
    return false
  end

  def access_denied
    respond_to do |accepts|
      accepts.html do
        store_location
        redirect_to :controller => '/admin', :action => 'login'
      end
    end
  end
end
