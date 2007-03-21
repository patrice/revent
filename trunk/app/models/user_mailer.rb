class UserMailer < ActionMailer::Base
  def current_theme
  end
  def force_liquid_template
  end
  def invite(event, message)
    @subject    = message[:subject]
    @body       = {:event => event, :body => message[:body]}
    @recipients = message[:recipients]
    @from       = "info@stepitup2007.org"
    @send_on    = Time.now
    @headers    = {}
  end
end
