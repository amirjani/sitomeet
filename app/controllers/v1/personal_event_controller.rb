class V1::PersonalEventController < ApplicationController
 #before_action :authenticate_request_user
 #skip_before_action :authenticate_request_user, :except => []

 #load_and_authorize_resource

  # here we create personal events 
 def create 
   render json: "a" , status: 400  
   return 
   #personalEvent = @current_user.event.build( personalEventParams )
   #if personalEvent.save
    #render json: personalEvent , status: 200 
   #else 
    #render json: personalEvent.erros , status: 400
   #end
 end 

 # private parts for initial what we want 
 #private 
 #def personalEventParams 
  #params.permit( :type , :date , :title , :description , :location_lat , :location_long , :address , :start_time , :end_time , :repeat_time , :notification_time , :end_of_repeat , :is_private , :is_verified , :photo )
 #end 
end
