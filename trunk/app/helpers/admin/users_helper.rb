module Admin::UsersHelper
  def events_column(record)
    record.events.collect {|e| link_to "#{e.start.strftime('%m/%e')} - #{e.name}", :controller => 'account/events', :action => 'show', :id => e.id}.join('<br> ')
  end
end
