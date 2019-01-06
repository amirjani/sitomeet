class V1::LookupController < ApplicationController
  

  def getLookup
    lookups = Lookup.where(category: params[:category])
    render json: lookups
  end


end
