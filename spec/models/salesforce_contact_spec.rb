require File.dirname(__FILE__) + '/../spec_helper.rb'

#gem 'activesalesforce'
require 'active_record/connection_adapters/rforce'

describe "SalesforceContact" do
  before do
#    Object.send(:remove_const, :SalesforceBase) if Object.const_defined?(:SalesforceBase)
#    Object.send(:remove_const, :SalesforceContact) if Object.const_defined?(:SalesforceContact)
#    load RAILS_ROOT + '/app/models/salesforce_base.rb'
#    load RAILS_ROOT + '/app/models/salesforce_contact.rb'

    RForce::Binding.stub!(:new).and_return(@binding = mock('binding'))
    @binding.stub!(:login)
    @binding.stub!(:describeSObject).and_return(stub_everything)
    SalesforceContact.establish_connection(:adapter => 'activesalesforce')
    SalesforceContact.set_table_name 'Contact'
  end

  after do
    SalesforceContact.flush_connections
  end

  it "should stub the connection" do
    @binding.stub!(:query).and_return(stub_everything)
    lambda {SalesforceContact.count}.should_not raise_error
  end

  it "should save" do
    contact = SalesforceContact.new# :last_name => 'tester'
    contact.connection.stub!(:insert).and_return(stub_everything)
    contact.save
  end

  it "should save to the right connection" do
#    SalesforceContact.connection_chooser = lambda {Site.current.id}
    Site.current = (@site1 = stub('site', :id => 1, :theme => 'first'))
    #SalesforceContact.should connect_to_site_1_acct
    SalesforceContact.count

    Site.current = (@site2 = stub('site', :id => 2, :theme => 'second'))
    #SalesforceContact.should connect_to_site_2_acct
    SalesforceContact.count
  end
end

=begin
describe "Salesforce::Contact" do
  describe "when created" do
    before do
      Site.stub!(:current_config_path).and_return(File.join(RAILS_ROOT, 'test', 'config'))
      @timestamp ||= Time.now.to_i
      @timestamp += 1
      @email = "revent_#{@timestamp}@mail.com"
      @contact = Salesforce::Contact.new(
        :first_name => 'Revent', :last_name => 'Test', :email => @email, 
        :phone => '5556667777', :mailing_street => '1370 Mission St.', 
        :mailing_state => "CA", :mailing_postal_code => '94114', 
        :mailing_country => "United States of America") 
    end

    def act!
      @contact.save
    end

    it "should create a contact in Salesforce" do
      act!
      Salesforce::Contact.find_by_email(@email).should_not be_nil
    end
  end
end
=end
