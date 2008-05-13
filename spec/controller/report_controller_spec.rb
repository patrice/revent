require File.dirname(__FILE__) + '/../spec_helper.rb'

describe ReportsController do
  before(:all) do
    @event = events(:dayofaction_sf)
    @user= {:first_name => 'bob', :last_name => 'barker', :email => 'bob.barker@chumgroup.org'}
    @report = {:event_id => @event.id, :text => 'we came. we saw. we kicked some ass.'}

    Attachment.attachment_options[:path_prefix] = "tmp/test_images"
    @uploaded_data = fixture_file_upload("test_image.jpg", "image/jpg")
    @attachments = {:caption => 'sail boat', :primary => true, :uploaded_data = @uploaded_data}
  end

  after(:all) do
  end

  describe "when creating a new report" do 
    fixtures :events
    it "should send uploaded files to starling" do

      @attachments = 

      post :create {:user => @user, :report => @report}
    end
    it "should add a user 
    it "should create a temporary copy of any attachments" do
      pending
      #post :create, {:report => {:event_id => 111, :text => "this is only a test", :attachments => {"1" => {:uploaded_data => "", :caption => ""} }}, :user => {:first_name => 'Patrice', :last_name => 'de Muizon', :email => 'patrice.idex@gmail.com'}
    end
  end
  describe "search for a report" do
    describe "by zip" do
      it "should display all reports within 100 miles of a zip code" 
      it "should display all reports if zip cannot be found" do
        pending
        post :search, {:zip => "06825"}
        response.should be_success
      end
    end
    describe "by state" do
      it "should display all reports in a state" do
        pending
      end
    end
  end

end
