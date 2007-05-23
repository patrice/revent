class SyncFlickr < ActiveRecord::Migration
  def self.up
    require 'open-uri'
    add_column :attachments, :flickr_id, :string
    Attachment.reset_column_information
    @all_attachments = Attachment.find(:all, :conditions => "parent_id IS NULL")
    @all_attachments.group_by {|a| a.report_id}.each do |report_id, attachments|
      say_with_time "Updating flickr_id for Report:#{report_id}" do
        flickr = Flickr.new(File.join(RAILS_ROOT, 'config', 'flickr',RAILS_ENV,'token.cache'))
        flickr_images_for_report = flickr.photos.search 'me', "stepitup#{report_id}"
        flickr_images_for_report.each do |flickr_image|
          file = open(flickr_image.sizes[:Original].source)
          flickr_file_content = file.read
          same_size = attachments.select {|a| a.size == file.size}
          same_size.each do |a|
            File.open(a.full_filename) do |f|
              local_file_content = f.read
              if local_file_content == flickr_file_content
                a.update_attribute(:flickr_id, flickr_image.id)
              end
            end
          end
          file.close!
        end
      end
    end
  end

  def self.down
    remove_column :attachments, :flickr_id
  end
end
