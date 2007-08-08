class Admin::BaseController < ApplicationController
  before_filter :login_required
  
protected
  def authorized?
    return true if current_user.admin?
    return true if current_user.events.include? @report.event
  end
end