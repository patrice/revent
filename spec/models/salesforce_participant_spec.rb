require File.dirname(__FILE__) + "/../spec_helper"

describe SalesforceParticipant do
  before do
=begin
    @sf_contact_obj = stub('sf_contact_obj', :remote_id => '123ABC')
    @user = mock(User)#, :salesforce_object => @sf_contact_obj)
    @user.should_receive(:salesforce_object).and_return(@sf_contact_object)
    SalesforceContact.stub!(:save_from_user).with(@user).and_return(stub('sf_contact', :id => '456DEF'))

    @sf_event_obj = stub('sf_event_obj', :remote_type => 'Event', :remote_id => '123ABC')
    @event = mock(Event) # , :salesforce_object => @sf_event_obj)
    @event.should_receive(:salesforce_object).and_return(@sf_event_obj)
    SalesforceEvent.stub!(:save_from_event).with(@event).and_return(stub('sf_event', :id => '456DEF'))

    @rsvp = stub(Rsvp, :user => @user, :event => @event, :created_at => Time.now)
=end
  end
  describe "for salesforce contact" do
    it "should use salesforce contact for attendee if it exists" do
      @sf_contact = stub(ServiceObject, :remote_id => String.random(10)) 
      @user = stub(User, :salesforce_object => @sf_contact)
      rsvp = stub(Rsvp, :user => @user, :event => stub_everything, :created_at => Time.now)
      SalesforceParticipant.translate_rsvp(rsvp)[:contact_id__c].should == @sf_contact.remote_id
    end
    it "should create a salesforce contact for attendee if it does not exist" do
      @user = stub(User, :salesforce_object => nil)
      rsvp = stub(Rsvp, :user => @user, :event => stub_everything, :created_at => Time.now)
      @sf_contact = stub(SalesforceContact, :id => '1234ABCD')
      SalesforceContact.should_receive(:save_from_user).with(@user).and_return(@sf_contact)
      SalesforceParticipant.translate_rsvp(rsvp)[:contact_id__c].should == @sf_contact.id
    end
  end
  describe "for salesforce event" do
    it "should use it for event attendee if it exists" do
      @sf_event = stub(ServiceObject, :remote_id => String.random(10)) 
      @event = stub(Event, :salesforce_object => @sf_event, :name => 'Test Event')
      rsvp = stub(Rsvp, :user => stub_everything, :event => @event, :created_at => Time.now)
      SalesforceParticipant.translate_rsvp(rsvp)[:event_id__c].should == @sf_event.remote_id
    end
    it "should create salesforce event if it does not exist" do
      @event = stub(Event, :salesforce_object => nil, :name => 'Test Event 2')
      rsvp = stub(Rsvp, :user => stub_everything, :event => @event, :created_at => Time.now)
      @sf_event = stub(SalesforceEvent, :id => String.random(10)) 
      SalesforceEvent.should_receive(:save_from_event).with(@event).and_return(@sf_event)
      SalesforceParticipant.translate_rsvp(rsvp)[:event_id__c].should == @sf_event.id
    end
  end
  it "should translate an rsvp into a salesforce Participant" do 
    pending
    r = create_rsvp
    SalesforceParticipant.translate_rsvp(rsvp) 
  end
end
