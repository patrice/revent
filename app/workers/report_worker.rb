class ReportWorker < Workling::Base
  def save_report(report_params)
    # might need to make this a Report.save
    # so we can use it in manage your event
    Report.create(report_params)
  end
end
