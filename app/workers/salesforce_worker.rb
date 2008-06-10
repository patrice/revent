class SalesforceWorker < Workling::Base
  def save_contact(options={})
    RAILS_DEFAULT_LOGGER.debug "SalesforceWorker received user id: #{options[:user_id]}"
    user = User.find(options[:user_id])
    sf_contact = SalesforceContact.save_from_user(user)
    ServiceObject.create(:mirrored => user, :remote_service => 'Salesforce', :remote_type => 'Contact', :remote_id => sf_contact.id)
    sf_contact
  end

  def save_event(options={})
    RAILS_DEFAULT_LOGGER.debug "SalesforceWorker received event id: #{options[:event_id]}"
    event = Event.find(options[:event_id])
    sf_event = SalesforceEvent.save_from_event(event)
    ServiceObject.create(:mirrored => event, :remote_service => 'Salesforce', :remote_type => 'Event', :remote_id => sf_event.id)
    sf_event
  end
end
