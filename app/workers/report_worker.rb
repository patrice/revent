require 'user'
require 'democracy_in_action_object'
require 'press_link'

class ReportWorker < Workling::Base
  def save_report(report)
    Site.current = report.event.calendar.site
    # might need to make this a Report.save
    # so we can use it in manage your event
    report.move_to_temp_files!
    report.save
  rescue NoMethodError
    logger.warn( "Report creation failed for event #{report.event_id}" )
  end
end
