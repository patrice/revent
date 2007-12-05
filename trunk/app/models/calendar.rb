class Calendar < ActiveRecord::Base
  validates_uniqueness_of :permalink, :scope => :site_id
  before_validation :escape_permalink
  def escape_permalink
    self.permalink = PermalinkFu.escape(self.permalink)
  end

  belongs_to :site

  @@deleted_events = []
  @@all_events = []
  
  has_many :public_events, 
           :class_name  => "Event",
           :conditions  => "private IS NULL OR private = FALSE"
  has_many :events do
    def unique_states
      states = proxy_target.collect {|e| e.state}.compact.uniq.select do |state|
        DaysOfAction::Geo::STATE_CENTERS.keys.reject {|c| :DC == c}.map{|c| c.to_s}.include?(state)
      end
      states.length
    end
    def reports
      @reports ||= proxy_target.collect {|e| e.reports}.flatten.compact
    end
    def published_reports
      @published_reports ||= reports.select {|r| r.published?}
    end
    def with_reports
      published_reports.collect {|r| r.event}.uniq
    end
  end

  has_many :published_reports, :through => :events, :source => "reports", :conditions => "reports.status = '#{Report::PUBLISHED}'"

  def self.any?
    self.count != 0
  end
  
  def past?
    self.event_end && (self.event_end + 1.day).at_beginning_of_day < Time.now
  end

  def flickr_tags(event_id = nil)
    tags = []
    if tag = flickr_tag
      tags << tag.to_s
      tags << (tag.to_s + event_id.to_s) if event_id
      tags << flickr_additional_tags.split(',') if flickr_additional_tags
    end
    tags.flatten
  end

  #XXX
  has_one :democracy_in_action_object, :as => :synced
  def democracy_in_action_synced_table
    'distributed_event'
  end
  def democracy_in_action_key
    democracy_in_action_object.key if democracy_in_action_object
  end
  #XXX

  has_many :triggers
  has_many :categories
  has_one :hostform

  def self.clear_deleted_events
    raise 'method deprecated, use DemocracyInAction::Util.clear_deleted_events'
  end

  def self.load_from_dia(id, *args)
    raise 'method deprecated, use DemocracyInAction::Util.load_from_dia'
  end
end
