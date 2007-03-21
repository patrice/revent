class Account::BlogsController < ApplicationController
  session :disabled => false
  before_filter :login_required

  def create
    @blog = Blog.new(params[:blog])
    @blog.save!
    flash[:notice] = 'Blog post saved'
    redirect_to :controller => 'account/events', :action => 'show', :id => @blog.event_id
  end

  def update
    @blog = Blog.find(params[:id])
    @blog.update_attributes(params[:blog])
    @blog.save!
    flash[:notice] = 'Blog post updated'
    redirect_to :controller => 'account/events', :action => 'show', :id => @blog.event_id
  end
end
