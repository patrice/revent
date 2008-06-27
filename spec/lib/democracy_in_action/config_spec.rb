require File.dirname(__FILE__) + '/../../spec_helper'

describe DemocracyInAction::Config do
  it "should read the DIA urls from the config file" do
    @config = DemocracyInAction::Config.new(File.join(RAILS_ROOT,'test','config','democracyinaction-config.yml'))
    @config['urls'].should == 
      { 'get'     => 'http://org2.democracyinaction.org/dia/api/get.jsp', 
        'process' => 'http://org2.democracyinaction.org/dia/api/process.jsp',
        'delete'  => 'http://org2.democracyinaction.org/dia/api/delete.jsp'}
  end
end
