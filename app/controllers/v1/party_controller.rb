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
  if event.save
   party = event.build_party(partyParams)
    if party.save
     if party.is_invite == true
      if params[:user_id]
       ivitedUserToParty = party.party_user.build(partyUserParams)
       if ivitedUserToParty.save
        render :json => {
         :event => event.as_json(:except => [:created_at , :updated_at]) , 
         :party => party.as_json(:except => [:created_at , :updated_at , :event_id]), 
         :ivitedUserToParty => ivitedUserToParty.as_json(:except => [:created_at , :updated_at , :party_id])
        } , status: 200
        return 
       else
        render json: ivitedUserToParty.errors , status: 422
        return
       end
      else
       render json: { message: " کاربرهای دعوت شده را مشخص کنید " } , status: 400
       return
      end
     if party.is_invite == false
      render :json => {
         :event => event.as_json(:except => [:created_at , :updated_at]) ,
         :party => party.as_json(:except => [:created_at , :updated_at , :event_id])
      } , status: 200
      return 
     else
      render json: { message: " پارامتر همراه را ارسال کنید " } , status: 422
      return
     end
    else
     render json: party.errors , status: 400
     return
    end
  else
   render json: party.is_invite
   return
   render json: event.errors , status: 400
   return
  end
 end
end
 #============================ private
 private

 def partyUserParams
  params.permit( :user_id )
 end

 def eventParams
  params.permit( :date , :title , :description , :location_lat , :location_long , :address , :start_time , :end_time , :repeat_time , :notification_time ,
:end_of_repeat , :is_private , :is_verified , :photo )
 end

 def partyParams
  params.permit( :theme , :is_invite )
 end

end
