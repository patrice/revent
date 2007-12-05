class RsvpMailer < ActiveMailer::Base  
  def thank_you(event, user)
    setup_email(user)
    @subject += 'Thank you for RSVP\'ing to ' + event.name
    @body[:event] = event
  end
  
protected
  def setup_email(user)
    host = Site.current.host
    name = Site.current.theme
    @recipients = "#{user.email}"
    @from        = "info@#{host}" 
    @subject     = "#{name} - "
    @sent_on     = Time.now
    @body[:user] = user
  end
end