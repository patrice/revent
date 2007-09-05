class Site < ActiveRecord::Base
  cattr_accessor :current

  has_many :events
  has_many :calendars do
    def current
#      find :first, :conditions => ["current = ?", true]
      proxy_target.detect {|c| c.current?}
    end
  end

  before_validation :downcase_host
  validates_uniqueness_of :host

  protected
    def downcase_host
      self.host = host.to_s.downcase
    end
end
