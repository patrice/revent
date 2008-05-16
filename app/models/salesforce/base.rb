#require 'activesalesforce'
class Salesforce::Base < ActiveRecord::Base
  self.abstract_class = true
  self.establish_connection :salesforce
  include ActiveSalesforce::ActiveRecord::Mixin 
end
