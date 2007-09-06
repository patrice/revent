class PoliticianInvite < ActiveRecord::Base
  belongs_to :user
  belongs_to :politician
  belongs_to :event
end
