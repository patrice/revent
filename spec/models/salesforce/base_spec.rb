require File.dirname(__FILE__) + '/../../spec_helper.rb'

describe "Salesforce::Base" do
  it "should establish connection with Salesforce" do
    Site.stub!(:current_config_path).and_return(File.join(RAILS_ROOT, 'test', 'config'))
    Salesforce::Contact.count # use this to initiate connection
    Salesforce::Base.connected?.should be_true
  end

  it "should raise an error when accessed with no salesforce configuration" do
    Site.stub!(:current_config_path).and_return('non_existant_path')
    lambda { act! }.should raise_error(ActiveRecord::ConnectionNotEstablished)
  end
end
