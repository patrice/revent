require File.dirname(__FILE__) + '/../../spec_helper.rb'

describe User do
  before(:all) do
    DemocracyInAction::API.stub!(:process).and_return(1111)
    Site.current = Site.find_by_host("events.stepitup2007.org")
  end

  describe "when created" do
    before do
      @user = new_user
    end
  end
end
