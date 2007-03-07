class Site < ActiveRecord::Base
  has_many :events

  before_validation :downcase_host
  validates_uniqueness_of :host

  protected
    def downcase_host
      self.host = host.to_s.downcase
    end
end
