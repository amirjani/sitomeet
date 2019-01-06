class V1::PartyController < ApplicationController

 before_action :authenticate_request_user
 load_and_authorize_resource
 # ============================ can can
 rescue_from CanCan::AccessDenied do | exception |
   render json: { alert: exception.message }
 end

 # =========================== create party event
 def createParty

  event = @current_user.event.build(eventParams)

  event.event_type = "party"
  event.is_private = true
  event.is_verified = true
  #1
  if event.valid?
    event.save
    party = event.build_party(partyParams)
    #2 
    if party.valid?
      party.save
      #3
      if party.is_invite == "true" or party.is_invite == 1
        #4
        if params[:user_id]
          ivitedUserToParty = party.party_user.build(partyUserParams)
          #5
          if ivitedUserToParty.save
            render :json => {
              :event => event.as_json(:except => [:created_at , :updated_at]) , 
              :party => party.as_json(:except => [:created_at , :updated_at , :event_id]), 
              :ivitedUserToParty => ivitedUserToParty.as_json(:except => [:created_at , :updated_at , :party_id])
            } , status: 200
            return
          #5
          else
            render json: ivitedUserToParty.errors , status:404
            return
          #5 
          end
        #4
        else
         render json: { message: "send ids of users" }
         return
        #4 
        end
      end
      #3
      if party.is_invite == "false" or party.is_invite == 0
        render :json => {
         :event => event.as_json(:except => [:created_at , :updated_at]) , 
         :party => party.as_json(:except => [:created_at , :updated_at , :event_id])
        } , status: 200
        return
      #3
      else
       render json: { message: "مشکلی پیش آمده است" } , status:422
       return
      #3
      end
    #2
    else
      render json: party.errors , status:422
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
 # =========================== get all of party event
 def  getAllPartyEvents
  page = params[:page] || 1 
  per = params[:per] || 10 
  
  render :json => {
   :event => @current_user.event.where( event_type: "party" ).page(page).per(per).as_json(:except => [:created_at , :updated_at] , include: {party: {include: :party_user}} )
  } , status: 200
 end
 
 # ===================== get specified event
 def getSpecifiedTimePartyEvent
   #1
   if params[:start_time] and params[:end_time]
     event = @current_user.event.where( event_type: "party" ).where( date: params[:start_time]..params[:end_time] ).all 
     render :json => {
       :event => event.as_json(:except => [:created_at , :updated_at] , include: {party: {include: :party_user}} )
    } , status:200
   #1
   else
    render json: { message: "پارامتر های شروع و پایان بازه را ارسال کنید" } , status: 422 
   #1
   end
 end

 # ========================== update party events
 def updateParty
   # 1
   if params[:id]
     event = @current_user.event.where( id: params[:id] ).where( event_type: "party").first
     # 2 
     if event
       # 3 
       if event.update(eventParams)
        party = event.party(partyParams)
        invite = event.party.party_user(partyUserParams)
        render :json => {
          :event => event.as_json(:except => [:created_at , :updated_at]) ,
          :party => party.as_json(:except => [:created_at , :updated_at]) ,
          :invite => invite.as_json(:except => [:created_at , :updated_at])
        } , status: 200
       # 3
       else 
         render json: event.errors , status: 422
       # 3 
       end
     # 2 
     else 
       render json: { message: " رویداد مورد نظر یافت نشد " } , status: 404
     # 2 
     end 
   # 1
   else
     render json: { message: " پارامتر آیدی را ارسال کنید " } , status: 404 
   # 1  
   end
 end

 # ========================== delete
 def deleteEvent
   if params[:id]
     party = Party.where(id: params[:id]).first.delete
     render json: { message: "deleted successfully" } , status: 200
   else
     render json: { message: "pass id" } , status: 422 
   end 
 end

 # =========================== get today event
 def todayParty
   event = @current_user.event.where(event_type: "party").where(date: Time.now.strftime('%F')).all
   if event
     render :json => {
       :event => event.as_json(:except => [:created_at , :updated_at] , include: {party: {include: :party_user}} )
     } , status: 200
   else
     render json: event.errors , status:400 
   end 
 end


 # ======================= get one party
 def getOneParty
   #1
   if params[:id]
     party = Party.where(id: params[:id] ).first
     render :json => {
       :party => party.as_json(:except => [:created_at , :updated_at] , :include => [:event , :party_user] )
    } , status:200
   #1
   else
    render json: { message: "پارامتر های شروع و پایان بازه را ارسال کنید" } , status: 422
   #1
   end
 end


 #============================ private
 private

 def partyUserParams
  params.permit(:user_id)
 end

 def eventParams
  params.permit(:date , :title , :description , :location_lat , :location_long , :address , :start_time , :end_time , :repeat_time , :notification_time , :end_of_repeat , :is_private , :is_verified , :photo )
 end

 def partyParams
  params.permit(:theme , :is_invite , :number_of_along)
 end

end
