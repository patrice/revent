class TriggerMailer < ActionMailer::Base
  def email(trigger, recipient)
    @from                 = ["trigger.from_name <#{trigger.from}>"]
    @headers["reply-to"]  = trigger.reply_to
    @recipients           = ["recipient.full_name <#{recipient.email}>"]
    @bcc                  = trigger.bcc
    @subject              = trigger.subject
    @body[:email_text]    = trigger.email_text
    @body[:email_html]    = trigger.email_html
  end
end
