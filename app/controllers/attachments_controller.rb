class AttachmentsController < ApplicationController
  session :disabled => false, :only => :destroy
  before_filter :login_required
  access_control :destroy => 'admin'

  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy
    expire_page :controller => "reports", :action => "show", :id => @attachment.report_id
    respond_to do |wants|
      wants.html { redirect_to admin_url(:controller => "reports", :action => "show", :id => @attachment.report_id) }
      wants.js do
        render :update do |page|
          page.remove "attachment_#{@attachment.id}" if @attachment
        end
      end
    end
  end
end
