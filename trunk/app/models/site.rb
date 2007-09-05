class Site < ActiveRecord::Base
  cattr_accessor :current
  def self.current_config_path
    current ? File.join(RAILS_ROOT, 'sites', current.id.to_s, 'config') : File.join(RAILS_ROOT, 'config')
  end

  has_many :users
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
