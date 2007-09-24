class PartnersController < ApplicationController
  skip_before_filter :calendar
  skip_before_filter :set_cache_root
  def index
    cookies[:partner] = params[:id] if params[:id]
    redirect_to home_url
  end
end
