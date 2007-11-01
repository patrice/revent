# gem install activeresource --source http://gems.rubyonrails.org
class Politician < ActiveRecord::Base
  has_many :politician_invites
  has_many :rsvps, :as => :attending
  has_many :events, :through => :rsvps
  acts_as_tree
  
  attr_reader :name # virtual attribute

  has_one :democracy_in_action_object, :as => :associated
  def democracy_in_action_recipient_key
    democracy_in_action_object['key'] if democracy_in_action_object
  end 
  after_save :sync_associated_to_democracy_in_action
  def sync_associated_to_democracy_in_action
    require 'democracyinaction'
    api = DemocracyInAction::API.new(DemocracyInAction::Config.new(File.join(Site.current_config_path, 'democracyinaction-config.yml')))
    recipient = { 
      'key' => democracy_in_action_recipient_key,
      'honorific' => title,
      'given_name' => first_name,
      'family_name' => last_name,
      'email' => email,
      'phone' => phone,
      'fax' => fax,
      'Preferred_Contact_Method' => 'Default'
    }
    key = api.process 'recipient', recipient
    unless democracy_in_action_object
      self.build_democracy_in_action_object :table => 'recipient', :key => key
    end
    local = api.get 'recipient', key
    local = local.first if local.is_a?(Array)
    self.democracy_in_action_object.local = local
    self.democracy_in_action_object.save
  end

  def full_name
    self.first_name + ' ' + self.last_name
  end

  def invited?
    !politician_invites.empty?
  end
  
  def invites
    politician_invites.length
  end
  
  def allow_invite?
    !rsvpd?
  end

  def attending?(event_id = nil)
    rsvpd? && rsvps.any? {|r| (event_id ? r.event_id == event_id : true) && !r.proxy}
  end

  def supporting?(event_id = nil)
    rsvpd? && rsvps.any? {|r| (event_id ? r.event_id == event_id : true) && r.proxy}
  end

  def rsvpd?
    !rsvps.empty?
  end
  
  def senator?
    district_type == 'FS'
  end

  def representative?
    district_type == 'FH'
  end  
end

class Legislator < Politician
end
