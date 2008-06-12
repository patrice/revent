require 'digest/sha1'
class User < ActiveRecord::Base
  has_many :events, :foreign_key => 'host_id'
  has_many :calendars
  has_many :reports
  has_many :rsvps
  has_many :attending, :through => :rsvps, :source => :event
  has_many :politician_invites
  belongs_to :profile_image, :class_name => 'Attachment', :foreign_key => 'profile_image_id'
  belongs_to :site
  before_create :set_site_id
  def set_site_id
    self.site_id ||= Site.current.id if Site.current
  end
  
  has_and_belongs_to_many :roles
  def admin?
    roles.any? {|r| 'admin' == r.title || 'developer' == r.title}
  end

  def developer?
    roles.any? {|r| 'developer' == r.title} 
  end

  def deferred?
    @deferred
  end
  attr_accessor :deferred

  has_one :salesforce_object, :as => :mirrored, :class_name => 'ServiceObject'
  after_save :sync_to_salesforce
  def sync_to_salesforce
    SalesforceWorker.async_save_contact(:user_id => self.id) if Site.current.salesforce_enabled?
  end

  has_one :democracy_in_action_object, :as => :synced
  # (extract me) to the plugin!!!
  # acts_as_mirrored? acts_as_synced?
  attr_accessor :democracy_in_action
  after_save :sync_to_democracy_in_action
  def sync_to_democracy_in_action
    return true unless File.exists?(File.join(Site.current_config_path, 'democracyinaction-config.yml'))
    return true if deferred?

    # return unless DemocracyInAction.sync? => returns true or can be overridden like authorized?
    # with something lke Site.current.uses_crm(DemocracyInAction)

    @democracy_in_action ||= {}
#    $DEBUG = true
    @d_attrs = {}
    attributes.each do |k,v|
      @d_attrs[k.titleize.gsub(' ', '_')] = v
    end
    @d_attrs['Zip'] = self.postal_code

    # probably makes more sense to use an object wrapper so it can handle supporter_custom and whatnot
    # supporter = DemocracyInActionSupporter.new
    # supporter.custom << @democracy_in_action[:supporter_custom]
    # OR @democracyinaction.select {|k,v| k =~ /supporter_/}.each
    supporter = @democracy_in_action[:supporter] || {}
    require 'democracyinaction'
    api = DemocracyInAction::API.new(DemocracyInAction::Config.new(File.join(Site.current_config_path, 'democracyinaction-config.yml')))
    supporter_key = api.process 'supporter', @d_attrs.merge(supporter)
    create_democracy_in_action_object :key => supporter_key, :table => 'supporter' unless self.democracy_in_action_object

    supporter_custom = @democracy_in_action[:supporter_custom] || {}
    supporter_custom_key = api.process('supporter_custom', {'supporter_KEY' => supporter_key}.merge(supporter_custom))
    return true
  end
  
  def democracy_in_action_key
    democracy_in_action_object.key if democracy_in_action_object
  end

  def self.create_from_democracy_in_action_supporter(site, supporter)
    u = User.find_or_initialize_by_site_id_and_email(site.id, supporter.Email)
    u.first_name = supporter.First_Name
    u.last_name = supporter.Last_Name
    u.phone = supporter.Phone
    u.state = supporter.State
    u.postal_code = supporter.Zip
    unless u.democracy_in_action_key
      dia_obj = DemocracyInActionObject.new(:table => 'supporter', :key => supporter.key)
      dia_obj.save
    end
    unless u.crypted_password || (u.password && host.password_confirmation)
      password = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
      u.password = u.password_confirmation = password
    end
    unless u.save
      logger.warn("Validation error(s) occurred when trying to create user from DemocracyInActionSupporter: #{u.errors.inspect}")
      u.save_with_validation(false)
    end
    dia_obj.synced = u
    dia_obj.save
  end
  
  def dia_group_key=(group_key)
    self.democracy_in_action ||= {}
    self.democracy_in_action['supporter'] ||= {}
    self.democracy_in_action['supporter']['link'] ||= {}
    self.democracy_in_action['supporter']['link']['groups'] = group_key
  end

  def dia_group_key
    democracy_in_action['supporter'] && 
    democracy_in_action['supporter']['link'] && 
    democracy_in_action['supporter']['link']['groups']
  end

  def dia_trigger_key=(dia_trigger_key)
    self.democracy_in_action ||= {}
    self.democracy_in_action['supporter'] ||= {}
    self.democracy_in_action['supporter']['email_trigger_KEYS'] = dia_trigger_key
  end

  def dia_trigger_key
    democracy_in_action['supporter'] && 
    democracy_in_action['supporter']['email_trigger_KEYS']
  end

  # end extract me

  # Virtual attribute for the unencrypted password
  attr_accessor :password

  validates_presence_of     :email
  validates_presence_of     :password,                   :if => :password_required?
  validates_presence_of     :password_confirmation,      :if => :password_required?
  validates_length_of       :password, :within => 4..40, :if => :password_required?
  validates_confirmation_of :password,                   :if => :password_required?
  validates_length_of       :email,    :within => 3..100
  validates_uniqueness_of   :email, :scope => :site_id, :case_sensitive => false
  before_save :encrypt_password
  before_create :make_activation_code
  after_save :deliver_email
  def deliver_email
    UserMailer.deliver_forgot_password(self) if self.recently_forgot_password?
    UserMailer.deliver_reset_password(self) if self.recently_reset_password?
  end

  # Authenticates a user by their email and unencrypted password.  Returns the user or nil.
  def self.authenticate(email, password)
    # check if this user is legit for this site 
    u = find_by_site_id_and_email(Site.current.id, email, :conditions => 'activated_at IS NOT NULL')
    return u if (u && u.authenticated?(password))
    # check if this is a developer account?
    u = find_by_email(email, :include => :roles, :conditions => "roles.title = 'developer'")
    u && u.authenticated?(password) ? u : nil
  end

  # Activates the user in the database.
  def activate
    @activated = true
    update_attributes(:activated_at => Time.now.utc, :activation_code => nil)
  end

  # Returns true if the user has just been activated.
  def recently_activated?
    @activated
  end

  def forgot_password
    @forgotten_password = true
    self.make_password_reset_code
  end

  def reset_password
    # First update the password_reset_code before setting the 
    # reset_password flag to avoid duplicate email notifications.
    update_attributes(:password_reset_code => nil)
    @reset_password = true
  end

  def recently_reset_password?
    @reset_password
  end

  def recently_forgot_password?
    @forgotten_password
  end

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def authenticated?(password)
    crypted_password == encrypt(password)
  end

  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at 
  end

  # These create and unset the fields required for remembering users between browser closes
  def remember_me
    self.remember_token_expires_at = 2.weeks.from_now.utc
    self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
    save(false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end

  def full_name
    [first_name, last_name].compact.join(' ')
  end
  alias name full_name

  def address
    [street, street_2, city, state, postal_code].compact.join(', ')
  end
  
  def attending?(event)
    self.attending.any? {|e| e.id == event.id}
    self.events.any? {|e| e.id == event.id}
  end

  # most recently hosted or attended event
  def effective_event
    (self.events + self.attending).max{|a,b| a.end <=> b.end}
  end  

  # get calendar for most recently hosted or attended event
  def effective_calendar
    effective_event ? effective_event.calendar : (Site.current.calendars.current || Site.current.calendars.first)
  end
  
  def country
    CountryCodes.find_by_numeric(self.country_code)[:name]
  end

  def country=(name)
    self.country_code = CountryCodes.find_by_name(name)[:numeric]
  end

  def city_state
    [city, (state || country)].join(', ')
  end
    
  protected
    # before filter 
    def encrypt_password
      return if password.blank?
      self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--") if new_record?
      self.crypted_password = encrypt(password)
    end
    
    def password_required?
      crypted_password.blank? || !password.blank?
    end

    def make_activation_code
      self.activation_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
    end
    def make_password_reset_code
      self.password_reset_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
    end
end
