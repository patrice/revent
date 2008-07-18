class ReportWorker < Workling::Base
  def save_report(report)
    Site.current = report.event.calendar.site
    # might need to make this a Report.save
    # so we can use it in manage your event
    report.save
  rescue NoMethodError
    logger.warn( "Report creation failed for event #{report.event_id}" )
  end
end
