class SalesforceWorker < Workling::Base
  def establish_connection
    SalesforceBase.flush_connections
    salesforce_config = File.join(Site.current_config_path, 'salesforce-config.yml')
    if File.exists?(salesforce_config)
      SalesforceBase.establish_connection YAML.load_file(salesforce_config)
    end
  end

  def sync_contacts
    User.find(:all, :conditions => ["salesforce_sync = 1"], :group => "site_id").each do |user|
      unless (Site.current == user.site_id)
        Site.current = user.site_id and establish_connection
      end
      sfcontact = SalesforceContact.create(
        :phone => user.phone,
        :first_name => user.first_name,
        :last_name => user.last_name,
        :mailing_address => user.street,
        :mailing_address2 => user.street2,
        :mailing_state => user.state,
        :mailing_country => user.country,
        :mailing_postal_code => user.postal_code)
      user.update_attribute(:salesforce_sync, false)
    end
  end

  def sync_events
    Event.find(:all, :conditions => ["salesforce_sync = 1"], :group => "site_id").each do |event|
      sfevent = SalesforceEvent.create(
        :activity_date_time => event.start,
        :subject => event.name,
        :who_id => event.host.salesforce_id
        )
      event.update_attribute(:salesforce_sync, false)

    end
  end
end
