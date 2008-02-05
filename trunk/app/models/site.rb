class Site < ActiveRecord::Base
  cattr_accessor :current
  def self.current_config_path
    current ? File.join(RAILS_ROOT, 'sites', current.id.to_s, 'config') : File.join(RAILS_ROOT, 'config')
  end

  has_many :users
  has_many :events
  has_many :triggers
  has_many :hostforms
  has_many :categories

  has_many :calendars do
    def current
      proxy_target.detect {|c| c.current?}
    end
  end

  def to_label
    "#{host}"
  end  

  before_validation :downcase_host
  validates_uniqueness_of :host

  @@flickr = []
  def self.flickr
    site_id = Site.current.id
    flickr_config_file = File.join(RAILS_ROOT,'sites',site_id.to_s,'config','flickr',RAILS_ENV,'flickr.yml')
    return nil if not File.exist?(flickr_config_file)
    @@flickr[site_id] ||= {}
    @@flickr[site_id][:config] ||= YAML.load_file(flickr_config_file)    
    @@flickr[site_id][:api] ||= Flickr.new(File.join(RAILS_ROOT,'sites',site_id.to_s,'config','flickr',RAILS_ENV,'token.cache'), @@flickr[site_id][:config]['api_key'], @@flickr[site_id][:config]['shared_secret'])
  end
  
  def flickr_user_id
    site_id = self.id
    flickr_config_file = File.join(RAILS_ROOT,'sites',site_id.to_s,'config','flickr',RAILS_ENV,'flickr.yml')
    return nil if not File.exist?(flickr_config_file)
    @@flickr[site_id] ||= {}
    @@flickr[site_id][:config] ||= YAML.load_file(flickr_config_file)    
    @@flickr[site_id][:config] ||= YAML.load_file(flickr_config_file)    
    @@flickr[site_id][:config]['user_id']
  end

  def self.clear_memcache
    Site.find(:all).each {|s| Cache.delete("site_for_host_#{s.host}")}
  end

  def clear_memcache
    Cache.delete("site_for_host_#{self.host}")
  end

  protected
    def downcase_host
      self.host = host.to_s.downcase
    end
    

end
