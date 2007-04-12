class Account::ReportsController < ApplicationController
  session :disabled => false
  before_filter :find_report
  before_filter :login_required

  def edit
    @report = Report.find(params[:id])
  end

  def update
    @report.update_attributes(params[:report])
    flash[:notice] = "report updated"
    redirect_to :controller => 'account/events', :action => 'show', :id => @report.event
  end

  def publish
    @report.publish
    respond_to do |format|
      format.js
      format.html { redirect_to :controller => "/account/events", :action => "show", :id => @report.event_id }
    end
  end

  def unpublish
    @report.unpublish
    respond_to do |format|
      format.js
      format.html { redirect_to :controller => "/account/events", :action => "show", :id => @report.event_id }
    end
  end

  def destroy
    @report.destroy
    respond_to do |format|
      format.js
    end
  end

  def primary
    @report
  end

  def primary
    @report.primary!
    flash[:notice] = "updated primary report"
    redirect_to :controller => 'account/events', :action => 'show', :id => @report.event
  end
  protected
  def find_report
    @report = Report.find(params[:id])
  end
  def authorized?
    return true if current_user.admin?
    return true if current_user.events.include? @report.event
  end
end
