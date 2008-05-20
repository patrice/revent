require File.dirname(__FILE__) + '/../spec_helper.rb'

describe User do
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead.
  # Then, you can remove it from this and the functional test.
  include AuthenticatedTestHelper

  before(:all) do
    DemocracyInAction::API.stub!(:process).and_return(1111)
    Site.current = Site.find_by_host("events.stepitup2007.org")
  end

  describe "when saved" do
    before do
      @user = new_user
    end

    it "should not overwrite an existing password" do
      @user.password = @user.password_confirmation = "secret"
      @user.save
      User.authenticate(@user.email, "secret")
    end

    it "should set a default password" do
      pending "default password currently set in events/rsvps/reports controller create method. move to model."
      u = create_user 
      u.crypted_password.should_not be_nil
    end

    it "should create a user" do
      assert_difference User, :count do
        @user.save
        assert !@user.new_record?, "#{@user.errors.full_messages.to_sentence}"
      end
    end

    it "should require a password" do
      assert_no_difference User, :count do
        @user.password = nil
        @user.save
        assert @user.errors.on(:password)
      end
    end

    it "should require password confirmation" do
      assert_no_difference User, :count do
        @user.password_confirmation = nil
        @user.save
        assert @user.errors.on(:password_confirmation)
      end
    end

    it "should require email" do
      assert_no_difference User, :count do
        @user.email = nil
        @user.save
        assert @user.errors.on(:email)
      end
    end
  end

  describe "when already existing" do
    before do
      @user = create_user(:password => "secret", :password_confirmation => "secret")
    end

    it "should allow resetting the password" do
      @user.update_attributes(:password => 'new password', :password_confirmation => 'new password')
      assert_equal @user, User.authenticate(@user.email, 'new password')
    end

    it "should not rehash a new password" do
      @user.update_attributes(:login => 'quentin2', :email => 'quentin2@example.com')
      assert_equal @user, User.authenticate('quentin2@example.com', 'secret')
    end

    it "should authenticate" do
      assert_equal @user, User.authenticate(@user.email, 'secret')
    end

    it "should set remember token" do
      @user.remember_me
      assert_not_nil @user.remember_token
      assert_not_nil @user.remember_token_expires_at
    end

    it "should unset remember token" do
      @user.remember_me
      assert_not_nil @user.remember_token
      @user.forget_me
      assert_nil @user.remember_token
    end
  end

  describe "integrates with DIA" do
    before do
      @user = new_user
      @dia_api = mock(DemocracyInAction::API)
      DemocracyInAction::API.stub!(:new).and_return(@dia_api)
    end

    it "should push user to DIA supporter" do
      @dia_api.should_receive(:process).twice.and_return('1111')
      @user.save
    end
  end
end