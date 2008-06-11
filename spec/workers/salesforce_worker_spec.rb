require File.dirname(__FILE__) + '/../spec_helper.rb'

describe SalesforceWorker do
  before do
    Site.stub!(:current_config_path).and_return(File.join(RAILS_ROOT,'test','config')) 
    @sf_contact = mock(SalesforceContact, :id => 222, :new_record? => true, :save => true)
    SalesforceContact.stub!(:save_from_user).and_return(@sf_contact)

    @user = create_user(:deferred => true)
  end

  it "should pass the user id" do
    User.should_receive(:find).with(@user.id).and_return(@user)
    SalesforceWorker.new.save_contact(:user_id => @user.id)
  end
  
  it "should create a contact" do
    User.stub!(:find).and_return(@user)
    SalesforceContact.should_receive(:save_from_user).and_return(@sf_contact)
    SalesforceWorker.new.save_contact(:user_id => @user.id)
  end
end
