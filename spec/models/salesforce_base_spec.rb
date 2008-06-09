require File.dirname(__FILE__) + '/../spec_helper.rb'

describe "SalesforceBase" do
#  it "should establish connection with Salesforce" do
#    Site.stub!(:current_config_path).and_return(File.join(RAILS_ROOT, 'test', 'config'))
#    Salesforce::Contact.count # use this to initiate connection
#    Salesforce::Base.connected?.should be_true
#  end

#  it "should raise an error when accessed with no salesforce configuration" do
#    Site.stub!(:current_config_path).and_return('non_existant_path')
#    lambda { act! }.should raise_error(ActiveRecord::ConnectionNotEstablished)
#  end

  before do
    Site.stub!(:config_path).and_return(File.join(RAILS_ROOT,'test','config'))
    SalesforceContact.make_connection(1)
    @sf_contact = SalesforceContact.new(SalesforceContact.translate(create_user))
  end

  it 'should save contact by id' do
    pending
    @sf_contact.should be_valid
    lambda {@sf_contact.save}.should change(SalesforceContact,:count)
  end
  it 'should find saved contact by email' do
    pending
    @sf_contact.save
    SalesforceContact.find(@sf_contact.id).id.should == @sf_contact.id
  end

end
