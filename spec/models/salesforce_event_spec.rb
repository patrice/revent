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
  it "should get who_id from salesforce_object, if it exists" do
    @event = events(:stepitup)
    SalesforceEvent.translate(@event)[:who_id].should == @event.host.salesforce_object.id
  end
  it "should create a new Salesforce Contact if host does not have a Salesforce object" do
    @event = events(:etc)
    SalesforceContact.should_receive(:save_from_user).with(@event.host).and_return(stub_everything)
    SalesforceEvent.translate(@event)
  end
end
