class SalesforceEvent < SalesforceBase
  class << self
    #  cannot set_table_name here because we need a valid connection (because it connects!  when we do set_table_name!  wtf!!!!
    #  set_table_name "Contact"
    def make_connection(id)
      config = File.join(Site.config_path(id), 'salesforce-config.yml')
      return unless File.exist?(config)
      SalesforceEvent.establish_connection(YAML.load_file(config))
      set_table_name('CustomEvent')
    end

    def save_from_event(event) 
      return unless self.make_connection(event.calendar.site.id)
      attribs = event.is_a?(Event) ? translate(event) : event
      if event.salesforce_object
        sf_event = SalesforceEvent.update(event.salesforce_object.remote_id, attribs) 
      else
        sf_event = SalesforceEvent.create(attribs)
        event.create_salesforce_object(:remote_service => 'Salesforce', :remote_type => 'CustomEvent', :remote_id => sf_event.id)
      end
      sf_event
    rescue ActiveSalesforce::ASFError => err
      logger.error("Error in SalesforceEvent.save_from_event with event id #{event.id}: #{err}")
    end

    def translate(event)
      host_id = event.host.salesforce_object ? 
         event.host.salesforce_object.remote_id : SalesforceContact.save_from_user(event.host).id
      { # who
        :host_id__c => host_id, 
        # what 
        :name__c  => event.name,
        :description__c => event.description,
        # when
        :start__c => event.start,
        :end__c => event.end,
        # where
        :location__c => event.location,
        :city__c => event.city,
        :state__c => event.state,
        :postal_code__c => event.postal_code,
        :country__c => event.country,
        :latitude__c => event.latitude,
        :longitude__c => event.longitude}
    end
  end
end
