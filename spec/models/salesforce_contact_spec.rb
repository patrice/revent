require File.dirname(__FILE__) + '/../spec_helper.rb'

#gem 'activesalesforce'
require 'active_record/connection_adapters/rforce'

def sforce_response_fixture(name)
  file = File.read("spec/fixtures/salesforce/#{name}_soap_response.dump") || raise('no file')
  Marshal.load(file)
end

describe "SalesforceContact" do
  before do
#    Object.send(:remove_const, :SalesforceBase) if Object.const_defined?(:SalesforceBase)
#    Object.send(:remove_const, :SalesforceContact) if Object.const_defined?(:SalesforceContact)
#    load RAILS_ROOT + '/app/models/salesforce_base.rb'
#    load RAILS_ROOT + '/app/models/salesforce_contact.rb'

    RForce::Binding.stub!(:new).and_return(@binding = mock('binding'))

    @binding.stub!(:login)
    @binding.stub!(:describeSObject).with(:sObjectType => 'Contact').and_return(sforce_response_fixture('describe_contact'))
    SalesforceContact.establish_connection(:adapter => 'activesalesforce')
    SalesforceContact.set_table_name 'Contact'
  end

  after do
    SalesforceContact.flush_connections
  end

  it "should stub the connection" do
    #very specific
    @binding.should_receive(:query).with(:queryString => "SELECT COUNT() FROM Contact   ").and_return(sforce_response_fixture('count_contact'))
    lambda {SalesforceContact.count}.should_not raise_error
  end

  it "should use the right connection" do
    #just make sure it has COUNT
    @binding.should_receive(:query) do |args|
      args[:queryString].should =~ /COUNT/
      sforce_response_fixture('count_contact')
    end.twice

    @binding.should_receive(:login).with("firstuser", "firstpass")
    SalesforceContact.establish_connection(:adapter => 'activesalesforce', :username => 'firstuser', :password => 'firstpass')
    SalesforceContact.set_table_name('Contact')
    SalesforceContact.count

    @binding.should_receive(:login).with("seconduser", "secondpass")
    SalesforceContact.establish_connection(:adapter => 'activesalesforce', :username => 'seconduser', :password => 'secondpass')
    SalesforceContact.set_table_name('Contact')
    SalesforceContact.count
  end

  describe "save" do
    before do
      @user = new_user
      SalesforceContact.stub!(:make_connection).and_return(true)
    end
    it "should accept a user argument" do
      SalesforceContact.stub!(:find_or_initialize_by_email).with(@user.email).and_return(stub_everything)
      lambda {SalesforceContact.save_from_user(@user)}.should_not raise_error
    end
    it "should set attributes" do
      @user.first_name = 'firstly'
      joe = stub_everything
      joe.should_receive(:update_attributes).with(SalesforceContact.translate(@user))
      SalesforceContact.stub!(:find_or_initialize_by_email).with(@user.email).and_return(joe)
      SalesforceContact.save_from_user(@user)
    end
  end

  describe "translate" do
    it "should translate a user to a salesforce attribute hash" do
      user = new_user(:last_name => 'lastly', :first_name => 'firstly', :state => 'CA')
      SalesforceContact.translate(user)[:mailing_state].should == 'CA'
    end
  end
end

describe "SalesforceContact", "when saving" do
  it "should use the right connection" do
    SalesforceContact.establish_connection(:adapter => 'activesalesforce')
#    binding = SalesforceContact.connection.instance_variable_get(:@connection)
#    raise binding.inspect

#    SalesforceContact.set_table_name 'Contact'

#    contact = SalesforceContact.new :last_name => 'tester'
#    contact.save!
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
