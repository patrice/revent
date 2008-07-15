require File.dirname(__FILE__) + '/../spec_helper'

describe ReportWorker do
  before do
    Site.stub!(:current).and_return(stub('site', :salesforce_enabled? => false))
    @report_params = {:text => 'dope', :event_id => create_event.id, :reporter_data => {:email => 'dude@example.com'}, :akismet_params => {} }
  end
  it "should save the report with the report_params" do
    Report.should_receive(:create).with(@report_params)
    ReportWorker.new.save_report( @report_params )
  end
end
