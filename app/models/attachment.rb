class Attachment < ActiveRecord::Base
  # NOTE: lifted wholesale from Mephisto
  # used for extra mime types that dont follow the convention
  @@extra_content_types = { :audio => ['application/ogg'], :video => ['application/x-shockwave-flash'], :pdf => ['application/pdf'] }.freeze
  cattr_reader :extra_content_types

  # use #send due to a ruby 1.8.2 issue
  @@video_condition = send(:sanitize_sql, ['content_type LIKE ? OR content_type IN (?)', 'video%', extra_content_types[:video]]).freeze
  @@audio_condition = send(:sanitize_sql, ['content_type LIKE ? OR content_type IN (?)', 'audio%', extra_content_types[:audio]]).freeze
  @@image_condition = send(:sanitize_sql, ['content_type IN (?)', Technoweenie::AttachmentFu.content_types]).freeze
  @@other_condition = send(:sanitize_sql, [
    'content_type NOT LIKE ? AND content_type NOT LIKE ? AND content_type NOT IN (?)',
    'audio%', 'video%', (extra_content_types[:video] + extra_content_types[:audio] + Technoweenie::AttachmentFu.content_types)]).freeze
  cattr_reader *%w(video audio image other).collect! { |t| "#{t}_condition".to_sym }

  class << self
    def video?(content_type)
      content_type.to_s =~ /^video/ || extra_content_types[:video].include?(content_type)
    end

    def audio?(content_type)
      content_type.to_s =~ /^audio/ || extra_content_types[:audio].include?(content_type)
    end

    def other?(content_type)
      ![:image, :video, :audio].any? { |a| send("#{a}?", content_type) }
    end

    def pdf?(content_type)
      extra_content_types[:pdf].include? content_type
    end

    def find_all_by_content_types(types, *args)
      with_content_types(types) { find *args }
    end

    def with_content_types(types, &block)
      with_scope(:find => { :conditions => types_to_conditions(types).join(' OR ') }, &block)
    end

    def types_to_conditions(types)
      types.collect! { |t| '(' + send("#{t}_condition") + ')' }
    end
  end

  @@document_content_types = ['application/pdf', 'application/msword', 'text/plain']
  @@image_content_types = [:image]

  @@document_condition = send(:sanitize_sql, ['content_type IN (?)', @@document_content_types]).freeze
  cattr_reader :document_content_types, :image_content_types, :document_condition
  if RAILS_ENV == 'test'
    has_attachment :storage => :file_system, :path_prefix => 'test/tmp/attachments', :content_type => [@@image_content_types, @@document_content_types].flatten, :thumbnails => { :lightbox => '490x390>', :list => '100x100', :display => '300x300' }, :max_size => 2.megabytes #generate print version after the fact
  elsif File.exists?(s3_config_file = File.join(RAILS_ROOT, 'config', 'amazon_s3.yml'))
    has_attachment :storage => :s3, :content_type => [Attachment.image_content_types, Attachment.document_content_types].flatten, :path_prefix => 'events/attachments', :thumbnails => { :lightbox => '490x390>', :list => '100x100', :display => '300x300' }, :bucket_name => 'events.radicaldesigns.org'
    self.attachment_options = AttachmentOptions.new(attachment_options)
  else
    has_attachment :storage => :file_system, :content_type => [@@image_content_types, @@document_content_types].flatten, :thumbnails => { :lightbox => '490x390>', :list => '100x100', :display => '300x300' }, :max_size => 2.megabytes 
  end
  validates_as_attachment
  def bucket_name
    attachment_options[:bucket_name] || @@bucket_name
  end

  [:video, :audio, :other, :pdf].each do |content|
    define_method("#{content}?") { self.class.send("#{content}?", content_type) }
  end

  belongs_to :user
  belongs_to :report
  belongs_to :event
  after_validation_on_create :set_event_id
  def set_event_id
    self.event_id ||= report.event_id if report
  end

  def primary!
    event = self.event || self.report.event
    event.reports.collect {|r| r.attachments}.flatten.each do |attachment|
      next if attachment == self
      attachment.update_attribute(:primary, false) if attachment.primary?
    end
    self.update_attribute(:primary, true)
  end

  def clear_temp_paths
    @temp_paths.clear
  end

  attr_accessor :tag_depot
#  after_save { GC.start } # please, hope this helps

  def flickr_title
    "#{report.event.name} - #{report.event.city}, #{report.event.state}"
  end

  after_save :send_to_flickr
  def send_to_flickr
    return true unless Site.flickr and report and report.published? and flickr_id.nil?

    data = self.temp_data || File.read(full_filename) 
    calendar = report.event.calendar
    if self.flickr_id = Site.flickr.photos.upload.upload_image( data, content_type, filename, flickr_title, caption, calendar.flickr_tags)
      photoset_result = Site.flickr.photosets.addPhoto( calendar.flickr_photoset, flickr_id ) if calendar.flickr_photoset and primary? 
      update_attribute(:flickr_id, self.flickr_id)
    end
    
    logger.info(flickr_id ? "FLICKR photo #{flickr_id} saved" : "FLICKR could not save photo #{flickr_title} to flickr")
    return true

    rescue XMLRPC::FaultException
      logger.error("FLICKR XMLRPC::Exception occurred while trying to upload #{flickr_title}.")
      return true
  end
end
