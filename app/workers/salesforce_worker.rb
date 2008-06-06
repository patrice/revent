class SalesforceWorker < Workling::Base
  def save_contact(options={})
    RAILS_DEFAULT_LOGGER.debug "SalesforceWorker received user id: #{options[:user_id]}"
    u = User.find(options[:user_id])
    SalesforceContact.create_with_user(u)
  end

=begin
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
=end
end
