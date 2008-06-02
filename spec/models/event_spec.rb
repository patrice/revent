require File.dirname(__FILE__) + '/../spec_helper.rb'

module EventFactory
  def generate_event
    event = Event.new(
      :id => 111, 
      :name => "San Francisco Day of Action", 
      :short_description => "Die-in in front of Federal Reserve building.",
      :description => "Arrive early and bring signs.  Perform die-in in front of Fed building.",
      :directions => "Take BART to Montgomery Station.",
      :location => "111 Montgomery St.", :city => "San Francisco", :state => "CA", :postal_code => "94114",
      :country_code => Event::COUNTRY_CODE_USA, :district => "CA08",
      :start => (Time.now + 1.week), :end => (Time.now + 1.week + 4.hours),
      :letter_script => "Dear Sir, Please attend our event to stop the war. Thank you, yours",
      :call_script => "Hello, Please attend our event to stop the war. Thank you",
      :private => false, :max_attendees => 200,
      :fallback_latitude => nil, :fallback_longitude => nil,
      :organization => "United For Peace and Justice")
    calendar_mock = mock_model(Calendar, :null_object => true, :event_start => 1.month.ago, :event_end => 1.month.from_now)
    event.stub!(:calendar).and_return(calendar_mock)
    event.calendar_id = calendar_mock.id
    event
  end
end

describe Event do 
  include EventFactory
  before(:each) do
    Site.stub!(:current_config_path).and_return(File.join(RAILS_ROOT, 'config'))

    # mock geocoder
    @geo = mock('geo', :lat => 77.7777, :lng => -111.1111, :precision => "street", :success => true)
    GeoKit::Geocoders::MultiGeocoder.stub!(:geocode).and_return(@geo)

    # mock democracy in action api
    @dia_api = mock('dia_api', :process => true)
    DemocracyInActionEvent.stub!(:api).and_return(@dia_api)
    
    # create event to use in specs
    @event = generate_event
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
  end
end
