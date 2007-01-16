class Attachment < ActiveRecord::Base
  # NOTE: lifted wholesale from Mephisto
  # used for extra mime types that dont follow the convention
  @@extra_content_types = { :audio => ['application/ogg'], :video => ['application/x-shockwave-flash'], :pdf => ['application/pdf'] }.freeze
  cattr_reader :extra_content_types

  # use #send due to a ruby 1.8.2 issue
  @@video_condition = send(:sanitize_sql, ['content_type LIKE ? OR content_type IN (?)', 'video%', extra_content_types[:video]]).freeze
  @@audio_condition = send(:sanitize_sql, ['content_type LIKE ? OR content_type IN (?)', 'audio%', extra_content_types[:audio]]).freeze
  @@image_condition = send(:sanitize_sql, ['content_type IN (?)', Technoweenie::ActsAsAttachment.content_types]).freeze
  @@other_condition = send(:sanitize_sql, [
    'content_type NOT LIKE ? AND content_type NOT LIKE ? AND content_type NOT IN (?)',
    'audio%', 'video%', (extra_content_types[:video] + extra_content_types[:audio] + Technoweenie::ActsAsAttachment.content_types)]).freeze
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

  acts_as_attachment :storage => :file_system, :content_type => :image, :thumbnails => { :lightbox => '490x390>', :list => '100x100', :display => '300x300' }, :max_size => 2.megabytes
  validates_as_attachment

  [:video, :audio, :other, :pdf].each do |content|
    define_method("#{content}?") { self.class.send("#{content}?", content_type) }
  end

  belongs_to :user
  belongs_to :report
  belongs_to :event
end
