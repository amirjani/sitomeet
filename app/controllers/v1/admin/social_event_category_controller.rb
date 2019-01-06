class V1::Admin::SocialEventCategoryController < ApplicationController

  before_action :authenticate_request_admin
  skip_before_action :authenticate_request_admin , :only => []

  # ============================ can can
  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do | exception |
    render json: { alert: exception.message }
  end


  # ============================ create method 
  def create 

    socialEvent = SocialEventCategory.new(socialEventParams)

    if socialEvent.save
      render json: socialEvent , status: 200
    else
      render json: socialEvent.errors , status:422
    end    

  end 

  # ============================ index 
  def getAll
    render json: SocialEventCategory.all
  end

  # ============================ update 
  def update
    if params[:id]
      socialEventCategory = SocialEventCategory.where(id: params[:id]).first
      if socialEventCategory.update(socialEventParams)
        render json: socialEventCategory , status: 200 
      else
        render json: socialEventCategory.errors , status: 404  
      end
    else
      render json: {message: "send id."} , status: 422
    end 
  end

  # ============================ delete
  def delete
    if params[:id]
      socialEventCategory = SocialEventCategory.where(id: params[:id]).first
      if socialEventCategory.delete
        render json: { message: "successfully deleted"} , status: 200
      else
        render json: socialEventCategory.errors , status: 404
      end
    else
      render json: {message: "send social event id."} , status: 422
    end  
  end 


  # ============================ private
  def socialEventParams
    params.permit(:title)
  end 

end
