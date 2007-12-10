class RsvpMailer < ActiveMailer::Base  

  # wrapper for deliver call that checks if dia triggers are set
  def self.send_thank_you(event, user)
    self.deliver_thank_you(event, user) unless Calendar.current.rsvp_dia_trigger_key
  end

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
