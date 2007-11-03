module ReportsHelper
  def primary_image_for(event)
    image = event.reports.collect {|r| r.attachments}.flatten.detect {|a| a.image? && a.primary}
    image ||= event.reports.collect {|r| r.attachments}.flatten.detect {|a| a.image? }
    image ? image_tag(image.public_filename(:list)) : nil
  end
end
