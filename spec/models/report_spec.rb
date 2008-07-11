require File.dirname(__FILE__) + '/../spec_helper.rb'

describe Report do
  describe "when created" do 
    before do
      @site = create_site
      @site.stub!(:salesforce_enabled?).and_return(false)
      Site.stub!(:current).and_return(@site)
      @host = @site.users.create( :first_name => 'hostesst', :email => 'jak@crack.com' )
      @calendar = create_calendar(:site => @site)
      @event = create_event( :calendar => @calendar, :host => @host, :country_code => 'GBR' )
    end

    it "should should update existing users" do
      @user = create_user :email => 'test@example.com', :site => @site
      @report = create_report :reporter_data => {:first_name => 'testy', :last_name => 'mctest', :email => 'test@example.com'}, :event => @event, :user => nil
#      User.find(@user).first_name.should == 'testy'
      User.find(:first, :conditions => { :first_name => 'testy', :site_id => @site }).should == @report.user
    end

    it "should create new users" do
      User.delete_all
      @report = create_report :reporter_data => {:first_name => 'testy', :last_name => 'mctest', :email => 'test@example.com'}, :event => @event, :user => nil
      User.find(:first, :conditions => { :first_name => 'testy', :site_id => @site }).should == @report.user
    end

    it "should create press links"

    it "should create attachments"

    it "should check akismet"

    it "should save to flickr"

    it "should tag attachments"

    it "should create embeds"
  end
end
