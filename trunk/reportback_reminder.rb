now = Time.now
24_hours_ago = now - 24.hours
events = Event.find(:all, :conditions => ["events.end > ? AND events.end <= ?", 24_hours_ago, now], :include => [:users])
events.each {|e| UserMailer.create_reportback_reminder(e)}

