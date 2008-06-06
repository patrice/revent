class SalesforceContact < SalesforceBase
  #  cannot set_table_name here because we need a valid connection (because it connects!  when we do set_table_name!  wtf!!!!
#  set_table_name "Contact"
 
  def self.make_connection
    config = File.join(Site.current_config_path, 'salesforce-config.yml')
    return unless File.exist?(config)
    establish_connection(YAML.load_file(config))
    set_table_name 'Contact'
  end

  def self.create_with_user(user) #create_with_user_and_checking_if_we_use_salesforce
    Site.current = Site.find(user.site_id)
    return unless self.make_connection
    attributes = user.is_a?(User) ? translate(user) : user
    create_without_user(attributes)
  end

  def self.translate(user)
    { :phone                => user.phone,
      :first_name           => user.first_name,
      :last_name            => user.last_name,
      :mailing_street       => user.street,
#      :mailing_street2      => user.street_2,
      :mailing_state        => user.state,
      :mailing_country      => user.country,
      :mailing_postal_code  => user.postal_code }
  end

  (class << self; self; end).alias_method_chain :create, :user
end
