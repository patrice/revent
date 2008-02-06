today = Time.now
yesterday = today - 1.day
events = Event.find(:all, :conditions => ["events.end > ? AND events.end <= ?", yesterday, today])
events.each do |e|
  trigger = e.calendar.triggers.find_by_name("Report Host Reminder") || e.calendar.site.triggers.find_by_name("Report Host Reminder")
  TriggerMailer.deliver_trigger(trigger, e.host, e, e.calendar.site.host) if trigger
end
