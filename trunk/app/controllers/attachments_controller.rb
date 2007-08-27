class AttachmentsController < ApplicationController
  skip_before_filter :set_site
  skip_before_filter :set_calendar

  session :disabled => false, :only => [:destroy]
  before_filter :login_required, :only => [:destroy]
  access_control :destroy => 'admin'

  def show
    @attachment = Attachment.find_by_parent_id_and_filename(params[:id], "#{params[:filename]}.#{params[:format]}") || Attachment.find_by_id_and_filename(params[:id], "#{params[:filename]}.#{params[:format]}") 
    redirect_to @attachment.public_filename
  end

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
