class ReportWorker < Workling::Base
  def save_report(report_params)
    report = Report.create( report_params )
  end
end
