require 'site'
require 'attachment'

def upload_images_to_flickr(attachments, options = {})
  unless options.empty?
    options.symbolize_keys
    async = options[:async] || true
    site_id = options[:site_id] || Site.current
    title = options[:title]
    tags = options[:tags]
    photoset = options[:photoset]
  end

  flickr = Site.flickr 
  return unless flickr
  attachments.each do |attachment|
    begin
      data = attachment.temp_data
      data ||= File.read(attachment.full_filename) if File.exists?(attachment.full_filename)
      data ||= open(attachment.public_filename).read
    	if async
    	  flickr.photos.upload.upload_image_async(data, attachment.content_type, attachment.filename, title, attachment.caption, tags)
    	else
    	  photo_id = flickr.photos.upload.upload_image(data, attachment.content_type, attachment.filename, title, attachment.caption, tags)
    	  attachment.update_attribute(:flickr_id, photo_id)
    	  flickr.photosets.addPhoto(photoset, photo_id) if (photoset and attachment.primary?)  # photoset = '72157602812476432'
    	end
    rescue XMLRPC::FaultException
    end
  end
end
