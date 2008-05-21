require 'activesalesforce'

class Salesforce::Base < ActiveRecord::Base
  self.abstract_class = true
  include ActiveSalesforce::ActiveRecord::Mixin 
  salesforce_config = File.join(Site.current_config_path, 'salesforce-config.yml')
  if File.exists?(salesforce_config)
    self.establish_connection YAML.load_file(salesforce_config)
  else
    raise ActiveRecord::ConnectionNotEstablished, 
      "Attempted to access Salesforce object on site with no salesforce configuration", caller
  end
end
