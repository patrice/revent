require 'time'
require 'event'
today = Time.now
yesterday = today - 86400 #24.hours
events = Event.find(:all, :conditions => ["events.end > ? AND events.end <= ?", yesterday, today], :include => [:users])
events.each {|e| UserMailer.create_reportback_reminder(e)}

