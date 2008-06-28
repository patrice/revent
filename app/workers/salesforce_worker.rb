class SalesforceWorker < Workling::Base
  def save_contact(options={})
    RAILS_DEFAULT_LOGGER.info "SalesforceWorker received user id: #{options[:user_id]}"
    SalesforceContact.save_from_user(User.find(options[:user_id]))
  end

  def delete_contact(options={})
    SalesforceContact.delete_contact(options[:contact_id])
  end

  def save_event(options={})
    RAILS_DEFAULT_LOGGER.info "SalesforceWorker received event id: #{options[:event_id]}"
    SalesforceEvent.save_from_event(Event.find(options[:event_id]))
  end

  def delete_event(options={})
    SalesforceEvent.delete_event(options[:event_id])
  end

  def save_rsvp(options={})
    RAILS_DEFAULT_LOGGER.info "SalesforceWorker received event id: #{options[:rsvp_id]}"
    SalesforceRsvp.save_from_rsvp(Rsvp.find(options[:rsvp_id]))
  end

end
