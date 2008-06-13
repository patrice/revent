require File.dirname(__FILE__) + "/../spec_helper"

describe SalesforceEventAttendee do
  before do
    @sf_contact_obj = stub('sf_contact_obj', :remote_id => '123ABC')
    @user = stub(User)#, :salesforce_object => @sf_contact_obj)
    @user.stub!(:salesforce_object => @sf_contact_object)
    SalesforceContact.stub!(:save_from_user).with(@user).and_return(stub('sf_contact', :id => '456DEF'))

    @sf_event_obj = stub('sf_event_obj', :remote_type => 'Event', :remote_id => '123ABC')
    @event = stub(Event, :salesforce_object => @sf_event_obj)
    SalesforceEvent.stub!(:save_from_event).with(@event).and_return(stub('sf_event', :id => '456DEF'))

    @rsvp = stub(Rsvp, :user => @user, :event => @event, :created_at => Time.now)
  end
  it "should 
  it "should translate an rsvp into a salesforce EventAttendee" do 
    pending
    r = create_rsvp
    SalesforceEventAttendee.translate(rsvp) 
  end
end
