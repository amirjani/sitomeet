class V1::ShakeController < ApplicationController

  before_action :authenticate_request_user

  def make
    near_event = Event.where('
			is_private = false
      			AND earth_box(ll_to_earth(?, ?), 5/1.609*1000)
      			@> ll_to_earth(location_lat, location_long)',params[:lat],params[:lng]).order("RANDOM()").first
   render json: near_event
  end


end
