require 'digest/sha1'
class User < ActiveRecord::Base
  has_many :medias
  has_many :events, :foreign_key => 'host_id'
  has_many :calendars
  has_many :reports
  has_many :rsvps
  has_many :attending, :through => :rsvps, :source => :event
  has_many :politician_invites
  has_and_belongs_to_many :roles

  def admin?
    roles.any? {|r| 'admin' == r.title}
  end

  has_one :democracy_in_action_object, :as => :synced
  # (extract me) to the plugin!!!
  # acts_as_mirrored? acts_as_synced?
  attr_writer :democracy_in_action
  after_save :sync_to_democracy_in_action
  def sync_to_democracy_in_action
    # return unless DemocracyInAction.sync? => returns true or can be overridden like authorized?
    # with something lke Site.current.uses_crm(DemocracyInAction)

    @democracy_in_action ||= {}
#    $DEBUG = true
    @d_attrs = {}
    attributes.each do |k,v|
      @d_attrs[k.titleize.gsub(' ', '_')] = v
    end
    # probably makes more sense to use an object wrapper so it can handle supporter_custom and whatnot
    # supporter = DemocracyInActionSupporter.new
    # supporter.custom << @democracy_in_action[:supporter_custom]
    # OR @democracyinaction.select {|k,v| k =~ /supporter_/}.each
    supporter = @democracy_in_action[:supporter] || {}
    require 'democracyinaction'
    api = DemocracyInAction::API.new API_OPTS
    supporter_key = api.process 'supporter', @d_attrs.merge(supporter)
    self.create_democracy_in_action_object :key => supporter_key, :table => 'supporter'

    supporter_custom = @democracy_in_action[:supporter_custom] || {}
    supporter_custom_key = api.process('supporter_custom', supporter_custom.merge(:supporter_KEY => supporter_key))
  end
  
  def democracy_in_action_key
    democracy_in_action_object.key if democracy_in_action_object
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
  validates_uniqueness_of   :email, :case_sensitive => false
  before_save :encrypt_password

  # Authenticates a user by their email and unencrypted password.  Returns the user or nil.
  def self.authenticate(email, password)
    u = find_by_email(email) # need to get the salt
    u && u.authenticated?(password) ? u : nil
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
end
