require File.dirname(__FILE__) + '/../spec_helper'

describe ServiceObject do
  before do 
    @user = create_user
  end
  it 'should associate with a user' do
    ServiceObject.create(:pushable => @user, :service_name => 'Salesforce', :service_table => 'Contact', :service_id => '1111')
    @user.salesforce_object.service_id.should == 1111
  end
end
