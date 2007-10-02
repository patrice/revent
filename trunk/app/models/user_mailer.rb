class UserMailer < ActionMailer::Base
  def current_theme
  end

  def force_liquid_template
  end

  def invite(from, event, message, host=nil)
    host ||= Site.current.host if Site.current && Site.current.host
    @subject    = message[:subject]
    @body       = {:event => event, :message => message[:body], :url => url_for(:host => host, :permalink => event.calendar.permalink, :controller => 'events', :action => 'show', :id => event)}
    @recipients = from
    @bcc        = message[:recipients]
    @from       = from
    @headers    = {}
  end

  def message(from, event, message)
    @subject    = message[:subject]
    @body       = {:event => event, :message => message[:body]}
    @recipients = from
    @bcc        = (event.attendees || event.to_democracy_in_action_event.attendees.collect {|a| User.new :email => a.Email}).collect {|a| a.email}.compact.join(',')
    @from       = from
    @headers    = {}
  end

  def invalid(event, errors)
    @subject    = 'invalid event'
    @body       =  {:text => event.to_yaml + errors}
    @recipients = 'seth@radicaldesigns.org'
    @from       = 'daysofaction@radicaldesigns.org'
    @headers    = {}
  end

  def activation(email, code, host=nil)
    host ||= Site.current.host if Site.current && Site.current.host
    subject       "Account Activation on #{host}"
    body          :url => url_for(:host => host, :controller => 'account', :action => 'activate', :id => code)
    recipients    email
    from          "info@#{host}"
    headers       {}
  end

  def forgot_password(user, host=nil)
    host ||= Site.current.host if Site.current && Site.current.host
    setup_email(user)
    @subject    += 'Request to change your password'
    @body[:url]  = "http://#{host}/account/reset_password/#{user.password_reset_code}" 
  end

  def reset_password(user)
    setup_email(user)
    @subject    += 'Your password has been reset'
  end

  protected
  def setup_email(user)
    host = Site.current && Site.current.host ? Site.current.host : 'events.stepitup2007.org'
    name = Site.current && Site.current.theme ? Site.current.theme : 'StepItUp'
    @recipients  = "#{user.email}" 
    @from        = "info@#{host}" 
    @subject     = "#{name} - "
    @sent_on     = Time.now
    @body[:user] = user
  end
end
