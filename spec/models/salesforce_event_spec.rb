require File.dirname(__FILE__) + '/../spec_helper.rb'

describe SalesforceEvent do
  before do
    @config = File.join(RAILS_ROOT,'test','config')
    Site.stub!(:config_path).and_return(@config)
    Site.stub!(:current).and_return(stub(Site, :id => 1, :salesforce_enabled? => false))
    SalesforceEvent.stub!(:set_table_name).and_return(true)
  end

  describe "translated" do 
    before do
      @event = create_event
      ServiceObject.create(:mirrored => @event.host, :remote_service => 'Salesforce', 
                           :remote_type => 'Contact', :remote_id => '1234ABCD')
    end
    it "host id should match salesforce_object id when exists" do
      SalesforceEvent.translate(@event)[:host_id__c].should == @event.host.salesforce_object.remote_id
    end
    it "should create a new Salesforce Contact if host does not have a Salesforce object" do
      @event2 = create_event
      SalesforceContact.should_receive(:save_from_user).with(@event2.host).and_return(stub(SalesforceContact, :id => 1234))
      SalesforceEvent.translate(@event2)
    end
  end
end

