class ReportWorker < Workling::Base
  def save_report(report_params)
    Site.current = Event.find( report_params[:event_id] ).calendar.site
    # might need to make this a Report.save
    # so we can use it in manage your event
    Report.create(report_params)
  rescue ActiveRecord::RecordNotFound  
    logger.warn( "Report creation failed for event #{report_params[:event_id]}" )
  end
end
