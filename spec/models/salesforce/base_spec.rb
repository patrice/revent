require File.dirname(__FILE__) + '/../../spec_helper.rb'

describe "Salesforce::Base" do
  def act!
    load 'salesforce/base.rb'
  end

  describe 'on successful load' do
    before do
      Site.stub!(:current_config_path).and_return(File.join(RAILS_ROOT, 'test', 'config'))
    end
    it "should establish connection with Salesforce" do
      act!
      Salesforce::Contact.count # use this to initiate connection
      Salesforce::Base.connected?.should be_true
    end
  end

  describe 'on unsuccessful load' do
    before do
      Site.stub!(:current_config_path).and_return('non_existant_path')
    end
    it "should raise an error when accessed with no salesforce configuration" do
      lambda { act! }.should raise_error(ActiveRecord::ConnectionNotEstablished)
    end
  end
end
