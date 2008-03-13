module Admin::ReportsHelper
  def attachments_column(report)
    report.attachments.length
  end

  def event_column(report)
    truncate(report.event.name, 30)
  end
  
  def text_column(report)
    truncate(report.text, 60)
  end

  def status_form_column(report, input_name)
    select_tag(input_name, options_for_select([Report::UNPUBLISHED, Report::PUBLISHED, ''], report.status))
  end
end
