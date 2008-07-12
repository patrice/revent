require File.dirname(__FILE__) + '/../spec_helper.rb'

describe Event do 
  before(:each) do
    Site.stub!(:current).and_return(stub(Site, :id => 1, :salesforce_enabled? => false))
    Site.stub!(:current_config_path).and_return(File.join(RAILS_ROOT, 'test', 'config'))

    # mock geocoder
    @geo = stub('geo', :lat => 77.7777, :lng => -111.1111, :precision => "street", :success => true)
    GeoKit::Geocoders::MultiGeocoder.stub!(:geocode).and_return(@geo)

    # mock democracy in action api
    @dia_api = stub('dia_api', :process => true)
    DemocracyInActionEvent.stub!(:api).and_return(@dia_api)
    
    @event = new_event
    @event.stub!(:set_district).and_return(true)
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
      pending #this test is stupid
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

  it "should calculate duration of event in minutes" do
    now = Time.now
    @event = Event.new(:start => now, :end => now + 2.hours)
    @event.duration_in_minutes.should == 120
  end

  describe "congressional district" do
    before do
      @event = new_event(:postal_code => '94114', :country_code => Event::COUNTRY_CODE_USA)
    end
    it "should set the congressional districts when saved" do
      @xml = "<?xml version=\"1.0\"?><data><entry id=\"radicaldesigns\"><address1></address1><address2></address2><region>CA</region><city>Oakland</city><latitude>37.824444</latitude><longitude>-122.230556</longitude><postal_code>94618</postal_code><postal_code_extension></postal_code_extension><district>CA09</district><regional_senate_district></regional_senate_district><regional_house_district></regional_house_district></entry></data>"
      Event.stub!(:open).and_return(@xml)
      @event.save
      @event.district.should == "CA09"
    end
    it "should select the first congressional district" do
      @xml = "<?xml version=\"1.0\"?><data><entry id=\"radicaldesigns\"><address1></address1><address2></address2><region>CA</region><city>San Francisco</city><latitude>37.759122</latitude><longitude>-122.438712</longitude><postal_code>94114</postal_code><postal_code_extension></postal_code_extension><district>CA08</district><district>CA12</district><multidistrict>true</multidistrict><regional_senate_district></regional_senate_district><regional_house_district></regional_house_district></entry></data>"
      Event.stub!(:open).and_return(@xml)
      @event.save
      @event.district.should == "CA08"
    end
  end
end
