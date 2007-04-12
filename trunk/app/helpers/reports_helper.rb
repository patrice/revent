module ReportsHelper
  def primary_image_for(object)
    image = object.attachments.detect {|a| a.image? && a.primary}
    image ||= object.attachments.detect {|a| a.image? }
    image ? image_tag(image.public_filename(:list)) : nil
  end
end
