class TriggerMailer < ActionMailer::Base
  def host_thank_you(trigger, event)
    setup(trigger, event.host, event)
    @body[:manage_url] = url_for(:controller => 'account/events', :action => 'show', :id => event, :only_path => false)
  end
  
  def rsvp_thank_you(trigger, rsvp)
    setup(trigger, rsvp.user, rsvp.event)
  end
  
  def report_thank_you(trigger, report)
    reporter = User.new(:first_name => report.reporter_name, :email => report.reporter_email)
    setup(trigger, reporter, report.event)
    @body[:report_url] = url_for(report_url(:event_id => event), :only_path => false)
  end
  
  def report_host_reminder(trigger, event)
    setup(trigger, event.host, event)
    @body[:report_url] = url_for(report_url(:event_id => event), :only_path => false)
  end
  
  private
  def setup(trigger, recipient, event)
    @from                 = ["#{trigger.from_name} <#{trigger.from}>"]
    @headers["reply-to"]  = trigger.reply_to
    @recipients           = ["#{recipient.full_name} <#{recipient.email}>"]
    @bcc                  = trigger.bcc
    @subject              = trigger.subject
    @body[:email_text]    = trigger.email_text
    @body[:email_html]    = trigger.email_html
    @body[:event]         = event
    @body[:event_url]     = url_for(:controller => 'events', :action => 'show', :id => event, :only_path => false)
  end
end
