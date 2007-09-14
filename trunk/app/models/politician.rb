# gem install activeresource --source http://gems.rubyonrails.org
class Politician < ActiveRecord::Base
  has_many :politician_invites
  has_many :rsvps, :as => :attending
  has_many :events, :through => :rsvps
  
  attr_reader :name # virtual attribute

  has_one :democracy_in_action_object, :as => :associated
  def democracy_in_action_recipient_key
    democracy_in_action_object['key'] if democracy_in_action_object
  end 

  def full_name
    self.first_name + ' ' + self.last_name
  end

  def invited?
    !politician_invites.empty?
  end

  def attending?
    !rsvps.empty?
  end
end

class Legislator < Politician
end
