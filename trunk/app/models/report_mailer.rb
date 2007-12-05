class ReportMailer < ActionMailer::Base
  def host_reminder(event)
    setup_email(event.host)
    @recipients  = "#{event.host.email}" 
    @subject += 'Report-back reminder for ' + event.name
    @body[:event] = event
  end
  
  def thank_you(report)
    setup_email(report.user)
    @recipients  = "#{report.reporter_email}" 
    @subject += 'Thank you for submitting a report for ' + report.event.name
    @body[:report] = report
  end
  
  protected
  def setup_email(user)
    host = Site.current.host
    name = Site.current.theme
    @from        = "info@#{host}" 
    @subject     = "#{name} - "
    @sent_on     = Time.now
  end
end
