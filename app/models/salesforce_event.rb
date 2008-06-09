class SalesforceEvent < SalesforceBase
  class << self
    #  cannot set_table_name here because we need a valid connection (because it connects!  when we do set_table_name!  wtf!!!!
    #  set_table_name "Contact"
    def make_connection(id)
      config = File.join(Site.config_path(id), 'salesforce-config.yml')
      return unless File.exist?(config)
      #raise self.inspect
      SalesforceEvent.establish_connection(YAML.load_file(config))
      set_table_name('Event')
    end

    def save_from_event(event) 
      return unless self.make_connection(event.calendar.site.id)
      SalesforceEvent.create(event.is_a?(Event) ? translate(event) : event)
    end

    def translate(event)
      # need salesforce contact id for who_id below
      # call save_from_user synchronously, since we're on queue
      { :subject => event.name,
        :description => event.description,
        :location => event.address_for_geocode,
        :duration_in_minutes => event.duration_in_minutes,
        :activity_date => event.start.strftime("%m/%d/%Y"),
        :activity_date_time => event.start,
        :is_child => true,
        :is_group_event => true,
        :is_private => false,
        :who_id => event.host.salesforce_object.service_id}
    end
  end
end
