class PartnersController < ApplicationController
  skip_before_filter :calendar
  skip_before_filter :set_cache_root
  def index
    cookies[:partner] = {:value => params[:id], :expires => 3.hours.from_now} if params[:id]
    redirect_to home_url
  end
end
