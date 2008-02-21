# see comments for def extend_scope in this file 
#class ActiveRecord::Associations::HasManyAssociation
class ActiveRecord::Associations::AssociationProxy
  attr_accessor :finder_sql
end

class Calendar < ActiveRecord::Base
  validates_uniqueness_of :permalink, :scope => :site_id
  validates_presence_of :site_id, :permalink, :name
  before_validation :escape_permalink
  def escape_permalink
    self.permalink = PermalinkFu.escape(self.permalink)
  end
=begin
  after_create :create_dia_distributed_event
  def create_dia_distributed_event
    #obj = self.democracy_in_action_object.build
    obj = DemocracyInActionObject.new
    obj.synced_type = "Calendar"
    obj.synced_id = calendar.id
    obj.table = democracy_in_action_synced_table
    obj.key = key 
    obj.save
  end
=end

  belongs_to :site
  
  @@deleted_events = []
  @@all_events = []
#  FINDER_SQL = 'SELECT * FROM events WHERE events.calendar_id IN (#{calendar_ids.unshift(id).join(\',\')})'
  has_many :reports, :through => :events
  has_many :published_reports, :through => :events, :source => "reports", :conditions => "reports.status = '#{Report::PUBLISHED}'"
  has_many :public_events, 
           :class_name => "Event",
           :conditions => "private IS NULL OR private = FALSE"
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

  # self-referential calendar relationship used for 'all' calendar
  belongs_to  :parent, :class_name => 'Calendar', :foreign_key => 'parent_id'
  has_many :calendars, :class_name => 'Calendar', :foreign_key => 'parent_id' do
    def current
      proxy_target.detect {|c| c.current?} || proxy_target.first
    end
  end

  # extend_scope allows us to see events across all calendars associated through has_many calendars.
  # This method overwrites HasManyAssociation#finder_sql for events and public_events associations
  # finder_sql is an option for has_many (:finder_sql => 'SQL statement'), but need to set it 
  # explicitly to have access to events.find(:all), etc.  
  # See bottom of this file for adding finder_sql accessor to HasManyAssociation
  def extend_scope
    events.finder_sql = "events.calendar_id IN (#{(calendar_ids << id).join(',')})"
    public_events.finder_sql = "events.calendar_id IN (#{(calendar_ids << id).join(',')})"
    reports.finder_sql = "events.calendar_id IN (#{(calendar_ids << id).join(',')})"
    published_reports.finder_sql = "events.calendar_id IN (#{(calendar_ids << id).join(',')})"
  end
  

  def self.any?
    self.count != 0
  end
  
  def past?
    self.event_end && (self.event_end + 1.day).at_beginning_of_day < Time.now
  end

  def flickr_tags(event_id = nil)
    tags = []
    if flickr_tag
      tags << flickr_tag.to_s
      tags << (flickr_tag.to_s + event_id.to_s) if event_id
      tags << flickr_additional_tags.split(',') if flickr_additional_tags
      tags.flatten
    end
    tags
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

