require File.dirname(__FILE__) + '/../spec_helper.rb'

describe Report do
  describe "create" do 
    before do
      @site = create_site
      @site.stub!(:salesforce_enabled?).and_return(false)
      Site.stub!(:current).and_return(@site)
      @calendar = create_calendar(:site => @site)
      @event = create_event( :calendar => @calendar, :country_code => 'GBR' )
    end

    describe "user" do
      before do
        @user = create_user :first_name => 'foxy', :email => 'test@example.com', :site => @site
      end

      it "should update if user exists" do
        @report = create_report :reporter_data => {:first_name => 'testy', :last_name => 'mctest', :email => 'test@example.com'}, :event => @event, :user => nil
        @user.reload.first_name.should == 'testy'
      end

      it "should set the report user to the existing user" do
        @report = new_report :event => @event, :user => nil
        @report.reporter_data = {:first_name => 'testy', :last_name => 'mctest', :email => 'test@example.com'}
        @report.save!
        @report.reload.user_id.should == @user.id
      end

      it "should set the user on create" do
        @report = Report.create(:event => @event, :reporter_data => {:first_name => 'testy', :last_name => 'mctest', :email => 'test@example.com'})
        @report.user_id.should == @user.id
      end

      it "should create new users" do
        @report = Report.create :reporter_data => {:first_name => 'testy', :last_name => 'mctest', :email => 'new@example.com'}, :event => @event
        User.find(:first, :conditions => { :email => 'new@example.com', :site_id => @site }).should == @report.user
      end

      it "should assign new users a random password" do
        @report = new_report
        @report.reporter_data = {:first_name => 'testy', :last_name => 'mctest', :email => 'newpassword@example.com'}
        @report.user.crypted_password.should_not be_nil
      end
    end

    it "should create press links" do
      @report = create_report(:press_link_data => [{:url => 'http://example.com', :text => 'the example site'}, {:url => 'http://other.example.com', :text => 'another one'}])
      @report.press_links(true).collect {|link| link.url}.should include('http://example.com')
    end

    describe "attachment" do
      it "should create attachments" do
        @uploaded_data = test_uploaded_file
        @report = create_report(:attachment_data => {'0' => {:caption => 'attachment 0', :uploaded_data => @uploaded_data}})
        @report.attachments(true).length.should == 1
        File.exist?(@report.attachments(true).first.full_filename).should be_true
      end
    end

    it "should validate all associated models"

    it "should tag attachments"

    it "should check akismet"

    it "should save to flickr"

    it "should create embeds"
  end
end
