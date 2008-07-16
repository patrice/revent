require File.dirname(__FILE__) + '/../spec_helper'

describe "Attachment" do
  before do
    Site.stub!(:current).and_return(stub('current_site', :id => 1, :salesforce_enabled? => false ))
    @attach = create_attachment
    @calendar = stub( Calendar, :flickr_tags => 'hello', :flickr_photoset => 'actionphotos') 
    @event = stub( Event, :name => 'test_event', :calendar => @calendar, :city => 'test city', :state => 'BL' )
    @attach.stub!(:report).and_return( stub( 'attached_report', :event => @event, :published? => false))
  end
  describe "flickr uploads" do
    it "does not work without a valid Flickr connection" do
      @upload_proxy.should_not_receive(:upload_image)
      Site.stub!(:flickr).and_return(false)
      @attach.send_to_flickr
    end
    describe "with a valid Flickr connection" do
      before do
        @upload_proxy = stub( 'uploads_proxy', :upload_image => true )
        @photo_proxy  = stub( 'photos_proxy', :upload => @upload_proxy )
        @photoset_proxy = stub( 'photoset_proxy', :addPhoto => true )
        @flickr_api = stub( 'flickr_api', :photos => @photo_proxy, :photosets => @photoset_proxy )
        Site.stub!(:flickr).and_return( @flickr_api )
        @attach.stub!(:full_filename).and_return( "#{RAILS_ROOT}/spec/fixtures/attachments/arrow.jpg" )
        @attach.stub!(:report).and_return( stub( 'attached_report', :event => @event, :published? => true))
      end
      it "checks for metadata" do
        @attach.should_receive(:flickr_title)
        @attach.send_to_flickr
      end

      it "works from tempfiles or full files" do
        @attach.should_receive(:temp_data).and_return( false )
        @attach.send_to_flickr
      end
      it "calls upload on the flickr api" do
        @upload_proxy.should_receive(:upload_image)
        @attach.send_to_flickr
      end
      it "updates the flickr api attribute" do
        @upload_proxy.stub!(:upload_image).and_return(5)
        @attach.should_receive(:update_attribute).with(:flickr_id, 5)
        @attach.send_to_flickr
      end

      it "re-saves the attachment" do
        @upload_proxy.stub!(:upload_image).and_return(5)
        @attach.should_receive(:save)
        @attach.send_to_flickr
      end
      it "does not save if the flickr upload failed" do
        @upload_proxy.stub!(:upload_image).and_return false 
        @attach.should_not_receive(:save)
        @attach.send_to_flickr
      end

      it "adds the photoset if the attachment is primary and the photoset is defined" do
        @calendar.stub!(:flickr_photoset).and_return( 5 )
        @attach.primary = true
        @photoset_proxy.should_receive(:addPhoto)
        @attach.send_to_flickr
      end

      it "does not add the photoset if no photoset is defined" do
        @calendar.stub!(:flickr_photoset).and_return(nil)
        @attach.primary = true
        @photoset_proxy.should_not_receive(:addPhoto)
        @attach.send_to_flickr
      end
      it "does not add the photoset if the attachment is not primary" do
        @calendar.stub!(:flickr_photoset).and_return( 5 )
        @photoset_proxy.should_not_receive(:addPhoto)
        @attach.send_to_flickr
      end

      it "rescues XMLRPC errors" do
        @flickr_api.stub!(:photos).and_raise( XMLRPC::FaultException.new( "problem", "yeah" ) )
        lambda{ @attach.send_to_flickr }.should_not raise_error
        
      end

      describe "after save update" do
        it "should not send non-report items to flickr" do
          @attach.stub!(:report).and_return(nil)
          @upload_proxy.should_not_receive(:upload_image)
          @attach.save!
        end
        describe "with report" do
          before do
            @attach.stub!(:report).and_return( stub( 'attached_report', :event => @event, :published? => true))
          end
          it "should send report items to flickr" do 
            @upload_proxy.should_receive(:upload_image)
            @attach.save
          end
          it "should not send unpublished items to flickr" do
            @attach.report.stub!(:published?).and_return(false)
            @upload_proxy.should_not_receive(:upload_image)
            @attach.save
          end
          it "should not send items that already have been uploaded"  do
            @attach.flickr_id = '123'
            @upload_proxy.should_not_receive(:upload_image)
          #  @attach.save
          end
        end
      end
    end
  end
end
