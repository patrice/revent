class PoliticianInvite < ActiveRecord::Base
  belongs_to: user
  belongs_to :politician
  belongs_to :event

  attr_reader :total_invites  # virtual attribute

  def total_invites
    @email_invites + @phone_invites + @letter_invites
  end
end
