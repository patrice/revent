# gem install activeresource --source http://gems.rubyonrails.org
class Politician < ActiveRecord::Base
  has_many :politician_invites
  
  attr_reader :name # virtual attribute

  def full_name
    self.first_name + ' ' + self.last_name
  end
end

class Legislator < Politician
end

class Candidate < Politician
end
