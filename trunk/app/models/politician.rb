class Politician < ActiveRecord::Base
  has_many :politican_invites
  
  attr_reader :name # virtual attribute

  def full_name
    self.first_name + ' ' + self.last_name
  end
end