class UploadAttachmentsToS3 < ActiveRecord::Migration
  ENV['RAILS_ENV'] ||= 'development'
  class OldAttachment < ActiveRecord::Base
    set_table_name 'attachments'
    has_attachment :storage => :file_system, :content_type => :image, :thumbnails => { :lightbox => '490x390>', :list => '100x100', :display => '300x300' }, :max_size => 10.megabytes #generate print version after the fact

    #needed to find our images in the old style path
    def partitioned_path(*args)
      [attachment_path_id.to_s] + args
    end
  end
  class NewAttachment < ActiveRecord::Base
    set_table_name 'attachments'
    has_attachment :storage => :s3, :path_prefix => 'events/attachments', :content_type => :image, :thumbnails => { :lightbox => '490x390>', :list => '100x100', :display => '300x300' }, :max_size => 10.megabytes #generate print version after the fact
    def thumbnailable?
      false
    end
    def already_uploaded?
      Technoweenie::AttachmentFu::Backends::S3Backend::S3Object.exists? full_filename, bucket_name
    end
    public :save_to_storage
  end
  def self.up
    attachments = NewAttachment.find(:all)
    attachments.each do |a|
      next if a.already_uploaded?
      raise 'still thumbnailable' if a.thumbnailable?
      current = OldAttachment.find(a.id)
      a.temp_data = File.read(current.full_filename)
      a.save_to_storage
    end
  end

  def self.down
  end
end
