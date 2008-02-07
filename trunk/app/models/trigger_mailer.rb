class TriggerMailer < ActionMailer::Base
  def trigger(trigger, recipient, event, host=nil)
    host ||= Site.current.host
    sub_tokens(trigger, event, host)
    @from                 = ["#{trigger.from_name} <#{trigger.from}>"]
    @headers["reply-to"]  = trigger.reply_to
    @recipients           = ["#{recipient.name} <#{recipient.email}>"]
    @bcc                  = trigger.bcc
    @subject              = trigger.subject
    @body = {:email_plain => trigger.email_plain, :email_html => trigger.email_html}
  end

  protected
  def sub_tokens(trigger, event, host)                          
    tokens = {}
    tokens['[EVENT_NAME]'] = event.name
    tokens['[EVENT_CITY]'] = event.city
    tokens['[EVENT_STATE]'] = event.state
    tokens['[EVENT_ADDRESS]'] = event.address
    tokens['[EVENT_START_DATE]'] = event.start_date
    tokens['[EVENT_START_TIME]'] = event.start_time
    tokens['[HOST_NAME]'] = event.host.name
    tokens['[HOST_PHONE]'] = event.host.phone
    tokens['[HOST_EMAIL]'] = event.host.email
    permalink = event.calendar.permalink
    tokens['[SIGNUP_LINK]'] = signup_url(:host => host, :permalink => permalink)
    tokens['[EVENT_LINK]'] = url_for(:host => host, :permalink => permalink, :controller => 'events', :action => 'show', :id => event)
    tokens['[MANAGE_LINK]'] = login_url(:host => host)
    tokens['[REPORT_LINK]'] = url_for(:host => host, :permalink => permalink, :controller => 'reports', :action => 'show', :event_id => event)
    tokens['[NEW_REPORT_LINK]'] = url_for(:host => host, :permalink => permalink, :controller => 'reports', :action => 'new', :id => event)
    tokens.each do |token, value|
      trigger.email_plain.gsub!(token, value) if trigger.email_plain
      trigger.email_html.gsub!(token, value) if trigger.email_html
    end
  end
end
