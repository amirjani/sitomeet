class V1::SocialEventController < ApplicationController

 before_action :authenticate_request_user
 load_and_authorize_resource

 # ============================ can can
 rescue_from CanCan::AccessDenied do | exception |
   render json: { alert: exception.message }
 end
 
 # ============================ social event create 
 def create 
   socialEvent = @current_user.social_event.build(socialEventParams)
   socialEvent.is_accepted = false 
   if socialEvent.valid? 
     socialEvent.save
     render json: socialEvent , status: 200 
     return
   else
     render json: socialEvent.errors , status: 422
     return  
   end 
 end 

 # ============================== get all 
 def getAll
   page = params[:page] || 1
   per = params[:per] || 10
   render json: @current_user.social_event.page(page).per(per) , status: 200 
   return
 end 

 # ============================== get from time to time 
 def between
   page = params[:page] || 1 
   per = params[:per] || 10 
   
   if params[:start_time] and params[:end_time]
     socialEvent = @current_user.social_event.where(date: params[:start_time]..params[:end_time]).order("date").page(page).per(per)
     if socialEvent
       render json: socialEvent , status: 200 
     else
       render json: { message: "social event not found"} , status: 404  
     end 
   else
     render json: { message: "send start time and end time" } , status: 422
     return  
   end 
 end

 # ============================== update 
 def update
   socialEvent = @current_user.social_event
   if socialEvent
     if socialEvent.update(socialEventParams)
       socialEvent.is_accepted = false 
       render json: socialEvent , status: 200 
     else
       render json: socialEvent.errors , status: 422
     end
   else
     render json: socialEvent.errors , status: 422
     return
   end 
 end 

 # ============================= delete 
 def delete
   socialEvent = @current_user.social_event.where(id: params[:id]).first
   if socialEvent
     if socialEvent.delete
       render json: { message: "deleted "} , status: 200
       return
     else
       render json: socialEvent.errors , status: 422
       return 
     end
   else
     render json: { message: "social event not found"} , status: 404
     return 
   end 
 end 

 # ============================== get one social event 
 def show
   if params[:id]
     socialEvent =  @current_user.social_event.where(id: params[:id]).first
     if socialEvent
       render json: socialEvent , status: 200 
       return  
     else 
       render json: { message: "social event not found" } , status: 404
       return 
     end 
   else 
     render json: { message: "send id of the social event" } , status: 422
     return
 end 

 # ============================== get today social event
 def today
   page = params[:page] || 1
   per = params[:per] || 10 

   socialEvent = @current_user.social_event.where(date: Time.now.strftime('%F')).page(page).per(per)
   
   render josn: socialEvent , status: 200 
 end 

 # ============================== privates
 def socialEventParams
   params.permit(:title , :description , :social_event_type_id , :social_event_category_id , :price , :is_available , :capacity , :photo)
 end 

end
