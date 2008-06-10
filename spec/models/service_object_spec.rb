require File.dirname(__FILE__) + '/../spec_helper'

describe ServiceObject do
  before do 
    @user = create_user
  end
  it 'should associate with a user' do
    ServiceObject.create(:mirrored => @user, :remote_service => 'Salesforce', :remote_type => 'Contact', :remote_id => '1111')
    @user.salesforce_object.remote_id.should == 1111
  end
end
