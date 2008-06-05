require File.dirname(__FILE__) + '/../../spec_helper.rb'

=begin
describe "Salesforce::Contact" do
  describe "when created" do
    before do
      Site.stub!(:current_config_path).and_return(File.join(RAILS_ROOT, 'test', 'config'))
      @timestamp ||= Time.now.to_i
      @timestamp += 1
      @email = "revent_#{@timestamp}@mail.com"
      @contact = Salesforce::Contact.new(
        :first_name => 'Revent', :last_name => 'Test', :email => @email, 
        :phone => '5556667777', :mailing_street => '1370 Mission St.', 
        :mailing_state => "CA", :mailing_postal_code => '94114', 
        :mailing_country => "United States of America") 
    end

    def act!
      @contact.save
    end

    it "should create a contact in Salesforce" do
      act!
      Salesforce::Contact.find_by_email(@email).should_not be_nil
    end
  end
end
=end
