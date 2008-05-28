class SalesforceBase < ActiveRecord::Base
  self.abstract_class = true
=begin
  salesforce_config = File.join(Site.current_config_path, 'salesforce-config.yml')
  if File.exists?(salesforce_config)
    self.establish_connection YAML.load_file(salesforce_config)
  end
=end
end
