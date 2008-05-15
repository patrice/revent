#require 'activesalesforce'
class Salesforce::Base < ActiveRecord::Base
  #self.abstract = true
  self.establish_connection :salesforce
  include ActiveSalesforce::ActiveRecord::Mixin 
end
