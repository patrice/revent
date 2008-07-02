require File.dirname(__FILE__) + '/../../spec_helper.rb'

describe SalesforceContact do
  before(:all) do
    @config = File.join(RAILS_ROOT,'test','config')
    Site.stub!(:config_path).and_return(@config)
    Site.stub!(:current).and_return(stub(Site, :id => 1, :salesforce_enabled? => false))
    SalesforceContact.make_connection nil
    #SalesforceContact.find(:all).each {|s| SalesforceContact.delete_contact(s.id) rescue ActiveSalesforce::ASFError}
  end

  it "should update a contact if one already exists with the users email" do
    SalesforceContact.stub!(:make_connection).and_return(true)
    bob = new_user(:first_name => 'bob', :site_id => 1)
    sf_charlie = SalesforceContact.create(:email => bob.email, :last_name => bob.last_name, :first_name => 'charlie')
    contact_id = sf_charlie.id
    sf_bob = SalesforceContact.save_from_user(bob)
    SalesforceContact.find(contact_id).first_name.should == 'bob'
  end

  it "should delete contacts" do
    contact_id = SalesforceContact.create(:email => 'test@example.com', :last_name => 'last').id
    SalesforceContact.delete_contact(contact_id)
    lambda { SalesforceContact.find(contact_id) }.should raise_error(ActiveRecord::RecordNotFound)
  end

  it "should not die if contact is already deleted" do
    contact_id = SalesforceContact.create(:email => 'test@example.com', :last_name => 'last').id
    SalesforceContact.delete_contact(contact_id)
    lambda { SalesforceContact.delete_contact(contact_id) }.should_not raise_error
  end

  it "should raise error if asf raises a different kind of error" do
    contact_id = SalesforceContact.create(:email => 'test@example.com', :last_name => 'last').id
    error = ActiveSalesforce::ASFError.new(SalesforceContact.logger, 'bad')
    SalesforceContact.delete_contact(contact_id)
    SalesforceContact.should_receive(:delete).and_raise(error)
    lambda { SalesforceContact.delete_contact(contact_id) }.should raise_error
  end
end
