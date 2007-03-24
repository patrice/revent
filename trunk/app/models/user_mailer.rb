class UserMailer < ActionMailer::Base
  def current_theme
  end

  def force_liquid_template
  end

  def invite(from, event, message, host='events.stepitup2007.org')
    @subject    = message[:subject]
    @body       = {:event => event, :message => message[:body], :url => url_for(:host => host, :controller => 'events', :action => 'show', :id => event)}
    @bcc        = message[:recipients]
    @from       = from
    @headers    = {}
  end

  def message(from, event, message)
    @subject    = message[:subject]
    @body       = {:event => event, :message => message[:body]}
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
    @subject    = 'Account Activation on events.stepitup2007.org'
    @body       = {:url =>  url_for(:host => host, :controller => 'account', :action => 'activate', :id => code)}
    @recipients = email
    @from       = "info@stepitup2007.org"
    @headrs     = {}
  end
end
