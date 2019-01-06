class V1::MeetingController < ApplicationController

 before_action :authenticate_request_user
 load_and_authorize_resource
 # ============================ can can
 rescue_from CanCan::AccessDenied do | exception |
   render json: { alert: exception.message }
 end 

 # ================ create 
 def create
   event = @current_user.event.build(eventParams)

   event.event_type = "meeting"
   event.is_private = true
   event.is_verified = true
   #1
   if event.valid?
     event.save
     meeting = event.build_meeting(meetingParams)
     #2 
     if meeting.valid?
      meeting.save
      #3
      if meeting.is_invite == "true" or meeting.is_invite == 1
        #4        
        if params[:user_id]
          ivitedUserToMeeting = meeting.meeting_user.build(meetingUserParams)
          #5
          if ivitedUserToMeeting.save
            render :json => {
              :event => event.as_json(:except => [:created_at , :updated_at] , include: {meeting: {include: :meeting_user}} )
            } , status: 200
            return
          #5
          else
            render json: ivitedUserToMeeting.errors , status:404
            return
          end
         else 
           render json: { message: "sent user ids"} , status: 422
           return
         end
       end
       #3
       if meeting.is_invite == "false" or meeting.is_invite == 0
        render :json => {
         :event => event.as_json(:except => [:created_at , :updated_at] , include: {meeting: {include: :meeting_user}}) ,
        } , status: 200
        return
      #3
      else
       render json: { message: "مشکلی پیش آمده است به مدیر اطلاع دهید" } , status:422
       return
      #3
      end
    #2
    else
      render json: meeting.errors , status:422
      return
    #2
    end
  #1
  else
    render json: event.errors , status:422
    return
  #1
  end
 end

 # ================ get all of meetings with pagination 
 def getAll
  
   page = params[:page] || 1
   per = params[:per] || 10

   meeting = @current_user.event.where(event_type: "meeting").page(page).per(per)

   render :json => {
     :event => meeting.as_json(:except => [:created_at , :updated_at] , include: {meeting: {include: :meeting_user}})
   } , status: 200
   return
 end  

 # ================ get between two time 
 def betweenTime
   page = params[:page] || 1
   per = params[:per] || 10

   if params[:start_time] and params[:end_time]
     meeting = @current_user.event.where(event_type: "meeting").where(date: params[:start_time]..params[:end_time]).page(page).per(per)
     
     render :json => {
       :event => meeting.as_json(:except => [:created_at , :updated_at] , include: {meeting: {include: :meeting_user}})
     } , status: 200
     return
   else
     render json: { message: "sent parameters completely" } , status: 422
   end
 end

 # ================ today
 def today
   page = params[:page] || 1
   per = params[:per] || 10
  
   meeting = @current_user.event.where(event_type: "meeting").where(date: Time.now.strftime('%F')).page(page).per(per)
  
   if meeting
     render :json => {
       :event => meeting.as_json(:except => [:created_at , :updated_at] , include: {meeting: {include: :meeting_user}})
     } , status: 200
     return
   else 
     render json: { message: "not found" } , status:404
     return
   end 
 end

 # =============== show 
 def show
   #event = @current_user.event(id: params[:id]).first
   meeting = Meeting.where(id: params[:id]).first
   if meeting
     render :json => {
       :meeting => meeting.as_json(:except => [:created_at , :updated_at] , :include => [:event , :meeting_user] )
     } , status: 200
     return
   else 
     render json: { message: "not found" } , status:404
   end
 end

 # ================ delete 
 def delete
   if params[:id]
     meeting = Meeting.where(id: params[:id]).first.delete
     render json: { message: "deleted successfully"} , status: 200
     return 
   else
     render json: { message: "meeting doesn't find" } , status: 404
     return 
   end
 end  

 # ================ private 
 private 
 
 def eventParams
   params.permit(:date , :title , :description , :location_lat , :location_long , :address , :start_time , :end_time , :repeat_time , :notification_time , :end_of_repeat , :is_private , :is_verified , :photo)
 end

 def meetingParams
   params.permit(:priority , :is_invite , :number_of_along)
 end

 def meetingUserParams
   params.permit(:user_id)
 end

end
