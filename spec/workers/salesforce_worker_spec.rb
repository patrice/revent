require File.dirname(__FILE__) + '/../spec_helper.rb'

describe SalesforceWorker do
  before do
    Site.stub!(:current_config_path).and_return(File.join(RAILS_ROOT,'test','config','salesforce-config.yml'))
    @user = default_user
    User.stub!(:find).and_return(@user)
  end

  it "should user to salesforce contact" do
    debugger
    SalesforceWorker.asynch_save_contact(:user_id => @user.id)
    sleep(20)
    sfcontact = SalesforceContact.find_by_last_name(@user.last_name)
    sfcontact.last_name.should == @user.last_name
  end
end
