require File.dirname(__FILE__) + '/../spec_helper.rb'

describe Site do
  describe "config_path" do
    it "should return a path in sites folder if given an id" do
      Site.config_path(1).should =~ /sites\/1/
    end
    it "should return a path in sites folder if given an id" do
      Site.config_path.should_not =~ /sites/
    end
  end
  describe "current_config_path" do
    it "should return a path in sites folder if given an id" do
      Site.current = Site.new
      Site.current.id = 1
      Site.current_config_path.should == Site.config_path(1)
    end
  end
end
