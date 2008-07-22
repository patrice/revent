require File.dirname(__FILE__) + '/../spec_helper'

describe ReportWorker do
  before do
    Site.stub!(:current).and_return(stub('site', :id => 1, :salesforce_enabled? => false))
    @report = Report.new({:text => 'dope', :event_id => create_event.id, :reporter_data => {:email => 'dude@example.com'}, :akismet_params => {}})
  end
  it "should save the report with the report_params" do
    @report.should_receive(:save)
    ReportWorker.new.save_report( @report )
  end
  it "should set Site.current" do
    Site.should_receive(:current=)
    ReportWorker.new.save_report( @report )
  end

  it "ensures that a valid event is sent" do
    worker = ReportWorker.new
    worker.logger.should_receive(:warn)
    @report.event_id = 'jjj'
    worker.save_report( @report )
  end

  describe "on the queue" do
    it "should be marshalable" do
      @report.attachment_data = {'0' => {:uploaded_data => test_uploaded_file}}
      lambda { Marshal.dump @report }.should_not raise_error
    end
    it "should be marshal loadable" do
      @report.attachment_data = {'0' => {:uploaded_data => (@file = test_uploaded_file)}}
      @report.make_local_copies!
      data = Marshal.dump @report
      @file.close(true)
      r = Marshal.load data
      File.exist?(r.attachments.first.temp_path).should be_true
    end
  end
end
