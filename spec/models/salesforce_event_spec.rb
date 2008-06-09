require File.dirname(__FILE__) + '/../spec_helper.rb'

require 'active_record/connection_adapters/rforce'

describe SalesforceEvent do
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
end
