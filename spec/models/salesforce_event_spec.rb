require File.dirname(__FILE__) + '/../spec_helper.rb'

describe SalesforceEvent do
  fixtures :events, :service_objects

  before do
    @config = File.join(RAILS_ROOT,'test','config')
    Site.stub!(:config_path).and_return(@config)
    SalesforceEvent.stub!(:set_table_name).and_return(true)
  end
  it "should be able to establish a connection" do
    lambda {SalesforceEvent.establish_connection(YAML.load_file(@config + '/salesforce-config.yml'))}.should_not raise_error
  end
  it "should make a connection" do
    lambda {SalesforceEvent.make_connection(1)}.should_not raise_error
  end
  it "should connect to salesforce database" do
    SalesforceEvent.should_receive(:establish_connection).and_return(true)
    SalesforceEvent.make_connection(1)
  end

  describe "when saved" do 
    before do
      SalesforceWorker.stub!(:async_save_event).and_return(true)
      @event = create_event
      ServiceObject.create(:mirrored => @event.host, :remote_service => 'Salesforce', :remote_type => 'Contact', :remote_id => '1234ABCD')
    end
    it "should get who id from salesforce_object, if it exists" do
      SalesforceEvent.translate(@event)[:who_id].should == @event.host.salesforce_object.remote_id
    end
    it "should create a new Salesforce Contact if host does not have a Salesforce object" do
      @event2 = create_event
      SalesforceContact.should_receive(:save_from_user).with(@event2.host).and_return(stub(SalesforceContact, :id => 1234))
      SalesforceEvent.translate(@event2)
    end
  end
end

