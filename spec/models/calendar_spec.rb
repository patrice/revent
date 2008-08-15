require File.dirname(__FILE__) + '/../spec_helper.rb'

describe Calendar do 
  fixtures :events, :reports, :calendars

  describe 'when created' do
    before do 
      Site.current = stub('site_stub', :salesforce_enabled? => false, :id => 777)
      @calendar = create_calendar
      @event = create_event :calendar => @calendar
      @report = create_report :event => @event, :status => 'published'
      @other_calendar = create_calendar
      @other_event = create_event :calendar => @other_calendar
      @other_report = create_report :event => @other_event, :status => 'published'
    end
    describe 'for calendars that are singular' do
      it "finds just the included events" do
        @calendar.events.should == [ @event ]
      end
      it "counts just the included events" do
        @calendar.events.size.should == 1
      end
      it "finds the reports" do
        @calendar.reports.should == [ @report ]
      end
    end
    describe 'for calendars that contain other calendars' do
      before do
        @other_calendar.parent = @calendar
        @calendar.calendars << @other_calendar
      end
      it "finder_sql should include both calendar ids" do
        @calendar.events.finder_sql.should match( Regexp.new( @calendar.id.to_s ))
        @calendar.events.finder_sql.should match( Regexp.new( @other_calendar.id.to_s ))
      end
      it "should contain all events from children calendars" do        
        @calendar.events.should == [ @event, @other_event ]
      end
      it "should count all events from child calendars" do        
        @calendar.events.size.should == 2
      end
      it "should support find" do        
        @calendar.events.find(:all).should == [ @event, @other_event ]
      end
      it "finds the reports" do
        @calendar.reports.should == [ @report, @other_report ]
      end
      it "should contain featured reports children calendars" do        
      end
    end
  end

  it "should contain featured reports" do
    pending
    @featured_report = reports(:ufpj_featured_report)
    @calendar = calendars(:ufpj_5yearstoomany)
    assert @calendar.featured_reports.include?(@featured_report)
  end
  
  def test_has_many_featured_reports_does_not_include_non_featured_reports
    @non_featured_report = reports(:ufpj_non_featured_report)
    @calendar = calendars(:ufpj_5yearstoomany)
    assert !@calendar.featured_reports.include?(@non_featured_report)
  end
  
  def test_load_from_dia
    assert true
    return # unless connecting to remote, and let's get this out of here
    mock = stub(:get => [{'event_KEY' => '1111', 'Event_Name' => 'name', 'Description' => 'desc', 'Address' => 'addr', 'City' => 'city', 'State' => 'state', 'Zip' => '94110', 'Start' => 1.hour.from_now, 'End' => 2.hours.from_now, 'Directions' => 'directions', 'Default_Tracking_Code' => 'stepitup'}])    
    DIA_API_Simple.stubs(:new).returns(mock)
    assert_nil Event.find_by_service_foreign_key('1111')
    result = Calendar.load_from_dia(1)
    assert result.is_a?(Calendar::DiaLoadResult)
    e = Event.find_by_service_foreign_key('1111')
    assert e
    assert e.tags.include?(Tag.find_by_name('stepitup'))
  end

    
  def test_private_events
    @calendar = calendars(:siu_nov)
    @event = events(:siu_private)
    assert @calendar.events.include?(@event)
    assert !@calendar.public_events.include?(@event)
  end
end
