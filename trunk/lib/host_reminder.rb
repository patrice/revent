require 'time'
require 'event'
today = Time.now
yesterday = today - 86400 #24.hours
events = Event.find(:all, :conditions => ["events.end > ? AND events.end <= ?", yesterday, today], :include => [:users])
#events.each {|e| ReportMailer.deliver_host_reminder(e)}
events.each {|e| ReportMailer.create_host_reminder(e)}

