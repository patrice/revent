class SalesforceEventAttendee < SalesforceBase
  has_one :salesforce_object, :as => :remote, :class_name => 'ServiceObject'

  #  cannot set_table_name here because we need a valid connection (because it connects!  when we do set_table_name!  wtf!!!!
  #  set_table_name "Contact"
  class << self
    def make_connection(id)
      config = File.join(Site.config_path(id), 'salesforce-config.yml')
      return unless File.exist?(config)
      establish_connection(YAML.load_file(config))
      set_table_name 'EventAttendee'
    end

    def save_from_rsvp(rsvp) #create_with_user_and_checking_if_we_use_salesforce
      return unless self.make_connection(rsvp.user.site_id)
      attribs = self.translate(rsvp)
      if rsvp.salesforce_object
        sf_event_attendee = SalesforceEventAttendee.update(rsvp.salesforce_object.remote_id, attribs)
      else
        sf_event_attendee = SalesforceEventAttendee.create(attribs)
        rsvp.create_salesforce_object(:remote_service => 'Salesforce', :remote_type => 'EventAttendee', :remote_id => sf_event_attendee.id)
      end
      sf_contact
    rescue ActiveSalesforce::ASFError => err
      logger.error("Error in SalesforceEventAttendee.save_from_user with user id #{rsvp.user.id}: #{err}")
    end

    def translate(rsvp)
      user = rsvp.user
      sf_attendee_id = user.salesforce_object ? 
        user.salesforce_object.remote_id : SalesforceContact.save_from_user(user).id
      event = rsvp.event
      sf_event_id = event.salesforce_object ? 
        event.salesforce_object.remote_id : SalesforceEvent.save_from_event(event).id
      { :attendee_id  => sf_attendee_id,
        :event_id => sf_event_id,
        :child_event_id => false,
        :status => "Accepted",
        :responded_date => rsvp.created_at.strftime("%m/%d/%Y")}
    end
  end
end
