class AccountController < ApplicationController
  session :disabled => false
  before_filter :login_required, :only => :profile

  def index
    redirect_to(:action => 'signup') unless logged_in? || User.count > 0
    redirect_to :action => 'profile'
  end

  def activate
    user = DemocracyInActionSupporter.find(:first, :conditions => "Other_Data_3='#{params[:id]}'")
    redirect_to signup_url and return unless user
    return unless request.post?
    flash[:notice] = 'passwords must match' and return unless params[:password] == params[:password_confirm]
    flash[:notice] = 'password must be at least 6 characters' and return unless params[:password].length >= 6
    user.Password = Digest::MD5.hexdigest(params[:password])
    user.Other_Data_3 = ''
    user.save
    self.current_user = user
    redirect_to profile_url
  end

  def send_activation
    user = DemocracyInActionSupporter.find(:first, :conditions => "Email='#{params[:email]}'")
    if !user
      flash[:notice] = "Email not found"
      redirect_to login_url
      return
    end
    activation_code = Digest::MD5.hexdigest("--#{Time.now}--stepitup--")
    user.Other_Data_3 = activation_code
    user.save
    UserMailer.deliver_activation(user.Email, activation_code)
    flash[:notice] = 'Account activation email delivered'
    redirect_to login_url
  end

  def profile
    @user = current_user
    return unless request.post?
    @user.update_atts(params[:user])
    @user.save
    flash.now[:notice] = "Your profile has been updated"
  end

  def events
    @user = current_user
    @event = current_user.find(params[:id])
    if current_user.supporter_KEY != @event.dia_event.supporter_KEY
      flash[:error] = 'You can only edit events you are hosting'
      redirect_to :action => 'profile' and return
    end
  end

  def old_events
    @user = current_user
    @dia_events = DemocracyInActionEvent.find(:all, :conditions => "supporter_KEY = #{@user.supporter_KEY}")
    @events = Event.find_all_by_service_foreign_key(@dia_events.collect {|e| e.event_KEY})
    return unless request.post?
    # do update
  end

  def login
    return unless request.post?
    if site.use_democracy_in_action_auth?
      self.current_user = DemocracyInActionSupporter.authenticate(params[:email], params[:password])
    else
      self.current_user = User.authenticate(params[:login], params[:password])
    end
    if current_user
      if params[:remember_me] == "1" && current_user.respond_to?(:remember_me)
        self.current_user.remember_me
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      redirect_back_or_default(:controller => '/account', :action => 'profile')
      flash[:notice] = "Logged in successfully"
    else
      flash[:notice] = "Login failed"
    end
  end

  def signup
    @user = User.new(params[:user])
    return unless request.post?
    @user.save!
    self.current_user = @user
    redirect_back_or_default(:controller => '/account', :action => 'profile')
    flash[:notice] = "Thanks for signing up!"
  rescue ActiveRecord::RecordInvalid
    render :action => 'signup'
  end

  #XXX: look at EventsController#create
  def new_signup
#    @user = User.new(params[:user])
    @supporter = DemocracyInActionSupporter.new(params[:democracy_in_action_supporter])
    @event = Event.new(params[:event])
    return unless request.post?
    @event.start = Time.local(params[:start][:year] || 2007, params[:start][:month] || 4, params[:start][:day] || 14, params[:time])
    raise @event.inspect
    #<input type="hidden" value="0,First_Name,Last_Name,Email,Phone," name="required" />
    #distributed_event_KEY = 239
    #email_trigger_KEYS=2590
    #Tracking_Code
    #Maximum_Attendees = 100
    #required = "Event_Name,Description,Start,End,Address,City,State,Directions,Zip,Maximum_Attendees"
    #updateRowValues=true
    #trigger="On New Distributed Event"
    #Status=Unconfirmed
    #add to group: 50838
    @user.save!
    self.current_user = @user
    redirect_back_or_default(:controller => '/account', :action => 'profile')
    flash[:notice] = "Thanks for signing up!"
  rescue ActiveRecord::RecordInvalid
    render :action => 'signup'
  end
  
  def logout
    self.current_user.forget_me if logged_in? && self.current_user.respond_to?(:forget_me)
    cookies.delete :auth_token
    reset_session
    redirect_back_or_default(home_url)
  end
end
