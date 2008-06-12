class SalesforceWorker < Workling::Base
  def save_contact(options={})
    RAILS_DEFAULT_LOGGER.info "SalesforceWorker received user id: #{options[:user_id]}"
    SalesforceContact.save_from_user(User.find(options[:user_id]))
  end

  def save_event(options={})
    RAILS_DEFAULT_LOGGER.info "SalesforceWorker received event id: #{options[:event_id]}"
    SalesforceEvent.save_from_event(Event.find(options[:event_id]))
  end
end
