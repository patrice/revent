module Admin::UsersHelper
  def events_column(user)
    unless user.events.empty?
      hosting = user.events[1..3].collect {|e| link_to "#{e.start.strftime('%m/%e')} - #{e.name}", :controller => 'account/events', :action => 'show', :id => e.id}
      if user.events.length > 3
        hosting << 'more...'
      end
      hosting.join('<br />')
    end
  end
  
  def created_at_column(user)
    "#{user.created_at.strftime('%m/%d/%Y')}"
  end
  def effective_calendar_column(user)
    user.effective_calendar.name
  end
end
