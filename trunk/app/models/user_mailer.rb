class UserMailer < ActionMailer::Base
  def current_theme
  end

  def force_liquid_template
  end

  def invite(from, event, message, host='events.stepitup2007.org')
    @subject    = message[:subject]
    @body       = {:event => event, :message => message[:body], :url => url_for(:host => host, :controller => 'events', :action => 'show', :id => event)}
    @recipients = from
    @bcc        = message[:recipients]
    @from       = from
    @headers    = {}
  end

  def message(from, event, message)
    @subject    = message[:subject]
    @body       = {:event => event, :message => message[:body]}
    @recipients = from
    @bcc        = event.dia_event.attendees.collect {|a| a.Email}.compact.join(',')
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

  def activation(email, code, host='events.stepitup2007.org')
    subject       'Account Activation on events.stepitup2007.org'
    body          :url => url_for(:host => host, :controller => 'account', :action => 'activate', :id => code)
    recipients    email
    from          "info@stepitup2007.org"
    headers       {}
  end

  def forgot_password(user)
    setup_email(user)
    @subject    += 'Request to change your password'
    @body[:url]  = "http://localhost:3000/account/reset_password/#{user.password_reset_code}" 
  end

  def reset_password(user)
    setup_email(user)
    @subject    += 'Your password has been reset'
  end

  protected
  def setup_email(user)
    @recipients  = "#{user.email}" 
    @from        = "info@events.stepitup2007.org" 
    @subject     = "StepItUp - "
    @sent_on     = Time.now
    @body[:user] = user
  end
end
