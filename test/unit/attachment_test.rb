require File.dirname(__FILE__) + '/../test_helper'

class AttachmentTest < Test::Unit::TestCase
  fixtures :attachments

  def setup 
    FileUtils.mkdir_p ASSET_PATH
  end
    
  def teardown
    FileUtils.rm_rf ASSET_PATH 
  end 

  # Replace this with your real tests.
  def test_truth
#    att = Attachment.create :uploaded_data => fixture_file_upload('files/8ball.jpg','image/jpg')
#    assert_file_exists File.join(ASSET_PATH, created_at.year.to_s, created_at.month.to_s, created_at.day.to_s, "#{filename}_tiny.png")
  end
end
