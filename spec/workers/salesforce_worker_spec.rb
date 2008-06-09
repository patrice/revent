require File.dirname(__FILE__) + '/../spec_helper.rb'

describe SalesforceWorker do
  before do
    Site.stub!(:current_config_path).and_return(File.join(RAILS_ROOT,'test','config')) #,'salesforce-config.yml'))
    @user = create_user
  end

  it "should pass the user id" do
    User.should_receive(:find).with(@user.id).and_return(@user)
    SalesforceWorker.new.save_contact(:user_id => @user.id)
  end
  
  it "should create a contact" do
    User.stub!(:find).and_return(@user)
    SalesforceContact.should_receive(:save_from_user)
    SalesforceWorker.new.save_contact(:user_id => @user.id)
  end
end
