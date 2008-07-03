require File.dirname(__FILE__) + '/../spec_helper.rb'

describe Event do 
  before(:each) do
    Site.stub!(:current).and_return(stub(Site, :id => 1, :salesforce_enabled? => false))
    Site.stub!(:current_config_path).and_return(File.join(RAILS_ROOT, 'test', 'config'))

    # mock geocoder
    @geo = mock('geo', :lat => 77.7777, :lng => -111.1111, :precision => "street", :success => true)
    GeoKit::Geocoders::MultiGeocoder.stub!(:geocode).and_return(@geo)

    # mock democracy in action api
    @dia_api = mock('dia_api', :process => true)
    DemocracyInActionEvent.stub!(:api).and_return(@dia_api)
    
    @event = new_event
  end

  describe 'in US' do
    before do
      @event.country = "United States of America"
      @event.city = "San Francisco"
      @event.postal_code = "94114"
    end
    it "should have a valid US state" do
      @event.state = 'BC'
      @event.should_not be_valid
    end
    it "should have a valid US zip" do
      @event.postal_code = 'V9N-231'
      @event.should_not be_valid
    end
    it "should be mappable" do
      @event.save
      @event.latitude.should == 77.7777 and @event.longitude.should == -111.1111
    end
  end
  describe 'in Canada' do
    before do
      @event.country = "Canada"
      @event.state = "BC"
      @event.postal_code = "V6B-3N9"
    end
    it "should have a valid Canadian province" do
      @event.state = 'CA'
      @event.should_not be_valid
    end
    it "should have a valid Canadian postal code" do
      @event.postal_code = '10001'
      @event.should_not be_valid
    end
    it "should be mappable" do
      @event.save
      @event.latitude.should == 77.7777 and @event.longitude.should == -111.1111
    end
  end
  describe "outside US and Canada" do
    before do
      @event.country = "Iran"
    end
    it "does not need a valid state" do
      @event.state = nil
      @event.should be_valid 
    end
    it "does not need a valid postal code" do
      @event.postal_code = nil
      @event.should be_valid 
    end
    it "does not need to be mappable" do
      @event.latitude, @event.longitude = nil, nil
      @event.should be_valid 
    end
  end
  it "should be convertible to DemocracyInActionEvent resource" do
    @event.to_democracy_in_action_event.should be_an_instance_of(DemocracyInActionEvent)
  end

  describe 'when created' do
    it "should push event to Democracy In Action" do
      @dia_api.should_receive(:process).and_return(true)
      @event.save
    end
  end

  describe 'when destroyed' do
    before do
      Site.stub!(:current).and_return(stub(Site, :salesforce_enabled? => true))
      SalesforceWorker.stub!(:async_save_event).and_return(true)

      @salesforce_object = stub('sf_object', :remote_id => '444HHH', :destroy => true)
      @event.stub!(:salesforce_object).and_return(@salesforce_object)
    end
    it "should not be in the db" do
      @event.save
      Event.find(@event.id).should_not be_nil
      @event.destroy
      lambda {Event.find(@event.id)}.should raise_error(ActiveRecord::RecordNotFound)
    end

    it "should delete event in Democracy In Action if it exists" do
      DemocracyInAction::API.stub!(:new).and_return(@dia_api)
      @event.stub!(:democracy_in_action_object).and_return(mock('object', :destroy => true, :key => 111))
      @dia_api.should_receive(:delete)
      @event.destroy
    end
    it "should rescue workling error if an exception is raised by async_delete_event" do
      SalesforceWorker.stub!(:async_delete_event).and_raise(Workling::WorklingError)
      @event.logger.should_receive(:error)
      @event.destroy
    end
    it "should delete event from Salesforce if it exists" do
      SalesforceWorker.should_receive(:async_delete_event).with(@salesforce_object.remote_id).and_return(true)
      @event.destroy
    end
  end

  describe 'should calculate duration of event in minutes' do
    now = Time.now
    @event = Event.new(:start => now, :end => now + 2.hours)
    @event.duration_in_minutes.should == 120
  end
end
