require File.dirname(__FILE__) + '/../spec_helper.rb'

$starling_path = "tmp/starling"
$starling_pid_file = File.join($starling_path, "starling.pid")

describe Report do
  before(:all) do
#    `sudo starling -d -p 332233 --pid #{$starling_pid_file} -q #{$starling_path}`  
  end
  describe "when created" do 
    it "should upload attachments to flickr" do
      
      
    end
  end
  after(:all) do
=begin
    File.open($starling_pid_file, "r") do |f| 
      pid = f.gets
      `sudo kill -9 #{pid}` 
    end
    `sudo rm #{$starling_pid_file}`
=end
  end
end