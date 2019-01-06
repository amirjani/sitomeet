class V1::SurpriseController < ApplicationController
  before_action :authenticate_request_user
  load_and_authorize_resource
  # ============================ can can
  rescue_from CanCan::AccessDenied do | exception |
    render json: { alert: exception.message }
  end

  # ============================ create 
  def create
    event = @current_user.event.build(eventParams)
    event.event_type = "surprise" 
    event.is_private = true 
    event.is_verified = true 

    if event.valid?
      event.save
      surprise = event.build_surprise(surpriseParams) 
      if surprise.valid?
        surprise.save
        if surprise.is_invite == "true" or surprise.is_invite == 1 
          if params[:user_id] 
            inviteUserToSurprise = surprise.surprise_user.build(surpriseUserParams)
            if inviteUserToSurprise.save
              render :json => {
                :event => event.as_json(:except => [:created_at , :updated_at] , include: {surprise: {include: :surprise_user}} )
              } , status: 200
            else 
              render json: invitedUserToSurprise.errors , status: 422
            end
          else
            render json: { message: "send user id parameter" }  , status: 422
          end
        elsif surprise.is_invite == "false" or surprise.is_invite == 0
          render :json => {
             :event => event.as_json(:except => [:created_at , :updated_at] , include: {surprise: {include: :surprise_user}} )
          } , status: 200
        else 
          render json: { message: "something went wrong" } , status: 422
        end
      else
        render json: surprise.errors , status: 422 
      end 

    else
      render json: event.errors , status: 422 
    end
  end

  # ========================== get between two time 
  def betweenTime
   page = params[:page] || 1
   per = params[:per] || 10

   if params[:start_time] and params[:end_time]
     surprise = @current_user.event.where(event_type: "surprise").where(date: params[:start_time]..params[:end_time]).page(page).per(per)

     render :json => {
       :event => surprise.as_json(:except => [:created_at , :updated_at] , include: {surprise: {include: :surprise_user}})
     } , status: 200
     return
   else
     render json: { message: "sent parameters completely" } , status: 422
   end
  end

  # =========================== get all 
  def getAll
    page = params[:page] || 1
    per = params[:per] || 10

    surprise = @current_user.event.where(event_type: "surprise").page(page).per(per)

   render :json => {
     :event => surprise.as_json(:except => [:created_at , :updated_at] , include: {surprise: {include: :surprise_user}})
   } , status: 200
   return

  end

  # ========================== get today surprise 
  def getToday
   page = params[:page] || 1
   per = params[:per] || 10

   surprise = @current_user.event.where(event_type: "surprise").where(date: Time.now.strftime('%F')).page(page).per(per)

   if surprise
     render :json => {
       :event => surprise.as_json(:except => [:created_at , :updated_at] , include: {surprise: {include: :surprise_user}})
     } , status: 200
     return
   else
     render json: { message: "not found" } , status:404
     return
   end
  end
 
  # =========================== show 
  def show

   surprise = Surprise.where(id: params[:id]).first
   if surprise
     render :json => {
       :surprise => surprise.as_json(:except => [:created_at , :updated_at] , :include => [:event , :surprise_user] )
     } , status: 200
     return
   else
     render json: { message: "not found" } , status:404
   end 
 
  end 

  # =========================== delete
  def delete
    if params[:id]
     surprise = Surprise.where(id: params[:id]).first.delete
     render json: { message: "deleted successfully"} , status: 200
     return
   else
     render json: { message: "surprise doesn't find" } , status: 404
     return
   end
  end

  # =========================== private 
  def eventParams
   params.permit(:date , :title , :description , :location_lat , :location_long , :address , :start_time , :end_time , :repeat_time , :notification_time , :end_of_repeat , :is_private , :is_verified , :photo)
  end

  def surpriseParams
    params.permit(:fake_title , :fake_description , :theme , :is_invite , :number_of_along , :user_to_surprise_id)
  end 

  def surpriseUserParams
    params.permit(:user_id)
  end
end
