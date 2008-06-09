class SalesforceWorker < Workling::Base
  def save_contact(options={})
    RAILS_DEFAULT_LOGGER.debug "SalesforceWorker received user id: #{options[:user_id]}"
    u = User.find(options[:user_id])
    SalesforceContact.save_from_user(u)
  end

  def save_event(options={})
    RAILS_DEFAULT_LOGGER.debug "SalesforceWorker received event id: #{options[:event_id]}"
    e = Event.find(options[:event_id])
    SalesforceEvent.save_from_event(e)
  end
end
