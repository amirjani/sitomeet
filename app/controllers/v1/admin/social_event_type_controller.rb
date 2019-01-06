class V1::Admin::SocialEventTypeController < ApplicationController

  before_action :authenticate_request_admin
  skip_before_action :authenticate_request_admin , :only => []

  # ============================ can can
  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do | exception |
    render json: { alert: exception.message }
  end

  # ============================ create 
  def create
    if params[:social_event_category_id]
       socialEventCategory = SocialEventCategory.where(id: params[:social_event_category_id]).first
       if socialEventCategory
         socialEventType = socialEventCategory.social_event_type.build(socialEventTypeParams)
         if socialEventType.save
           render json: socialEventType , status:200
         else
           render json: socialEventType.errors , status:422 
         end
       else
         render json: { message: "social event category not found."} , status: 404  
       end
    else
      render json: { message: "send social event category id." } , status: 422 
    end
  end 

  # ============================ get all category's type
  def categoryType
    if params[:social_event_category_id]
       socialEventCategory = SocialEventCategory.where(id: params[:social_event_category_id]).first
       if socialEventCategory
         render json: socialEventCategory.social_event_type , status: 200 
       else 
         render json: { message: "social event category not found."} , status: 404
       end 
    else
      render json: { message: "send social event category id." } , status: 422 
    end
  end 

  # ============================ delete a type 
  def delete
    if params[:social_event_type_id]
      socialEventType = SocialEventType.where(id: params[:social_event_type_id]).first
      if socialEventType.delete 
        render json: { message: "deleted successfully." } , status: 200
      else 
        render json: socialEventType.errors , status: 422
      end
    else
      render json: { message: "send social event type id." } , status: 422 
    end 
  end

  # ============================ update 
  def update
    if params[:social_event_type_id]
       socialEventType = SocialEventType.where(id: params[:social_event_type_id]).first
       if socialEventType.update(socialEventTypeParams)
         render json: socialEventType , status: 200
       else
         render json: socialEventType.errors , status: 422
       end
    else
      render json: { message: "send social event type id." } , status: 422
    end 
  end 

  # ============================ private
  private 

  def socialEventTypeParams
    params.permit(:social_event_category_id , :title)
  end

end
