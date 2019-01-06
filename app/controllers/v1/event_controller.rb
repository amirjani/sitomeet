class V1::EventController < ApplicationController
 before_action :authenticate_request_user
 load_and_authorize_resource

 # ============================ can can
 rescue_from CanCan::AccessDenied do | exception |
   render json: { alert: exception.message }
 end

 # ===========================  here we create personal events 
 def personalEventCreate
   personalEvent = @current_user.event.build( personalEventParams )
   personalEvent.event_type = "personal"
   personalEvent.is_private = true
   personalEvent.is_verified = true
   if params[:start_time] > params[:end_time]
    render json: {messsage: "تاریخ شروع بزرگتر از تاریخ پایان است"}
   else
    if personalEvent.save
     render json: personalEvent , status: 200
    else
    render json: personalEvent.errors , status: 400
    end
   end
 end

 # ========================= get all of user personal event
 def getAllPersonalEvent
  page = params[:page] || 1 
  per = params[:per] || 10
  render json: @current_user.event.where( event_type: "personal" ).page(page).per(per) , status: :ok
 end

 # ========================= get a month of user personal event
 def getMonthPersonalEvent
  if params[:start_time] and params[:end_time]
   render json: @current_user.event.where( event_type: "personal" ).where( date: params[:start_time]..params[:end_time] ).order("date").all , status: 200
   return
  else 
   render json: { message: "اطلاعات را یه صورت کامل پاس دهید" }, status: 422
  end 
 end
 
 # ======================== personal event update 
 def eventChange
  if params[:id]
   @personalEvent = @current_user.event.where(id: params[:id]).first 
   if @personalEvent
    if @personalEvent.update(personalEventParams)
     render json: @personalEvent , status: 200
    else
     render json: @personalEvent.errors , status: 400
    end 
   else
    render json: @personalEvent.errors , status: 404
   end
  else
   render json: { message: "پارامتر ها را به صورت کامل ارسال کنید" } , status: 422
  end
 end 
 
 # ========================== personal evenet delete
 def personalEventDelete
 if params[:id]
   personalEvent = @current_user.event.where( id: params[:id]).first
   if personalEvent
    if personalEvent.delete
     render json: { message: "حذف شد"} , status: :ok
     return
    else
     render json: personalEvent.errors , status: 400
     return
    end
   else
    render json: { message: "برنامه شما پیدا نشد" } , status: 404
    return
   end
  else
   render json: { message: "پارامتر ها را به صورت کامل ارسال کنید" } , status: 422
   return
  end
 end 
 
 # ========================== get only one event
 def getOnePersonalEvent
  if params[:id]
   render json: @current_user.event.where( id: params[:id]).where(event_type: "personal" ).first , status: 200
  else 
   render json: { message: "پارامتر ها را به صورت کامل ارسال کنید" } , status: 422 
  end 
 end
 
 # ======================== get today event
 def getTodayPersonalEvent
   render json: @current_user.event.where( date: Time.now.strftime('%F') ).all , status: 200 
 end


 # private parts for initial what we want 
 private 

 def personalEventParams 
  params.permit( :date , :title , :description , :location_lat , :location_long , :address , :start_time , :end_time , :repeat_time , :notification_time , :end_of_repeat , :is_private , :is_verified , :photo)
 end

end
