class Account::BlogsController < ApplicationController
  session :disabled => false
  before_filter :login_required
  after_filter :expire_page_cache

  def expire_page_cache
    expire_page :controller => '/events', :action => 'show', :id => @blog.event_id
  end

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
