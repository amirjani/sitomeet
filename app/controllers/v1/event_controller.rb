class V1::EventController < ApplicationController

  before_action :authenticate_request_user
  skip_before_action :authenticate_request_user, :only => []
  load_and_authorize_resource

  # ============================ can can
  rescue_from CanCan::AccessDenied do | exception |
    render json: { alert: exception.message }
  end

  # ============================ create event
  # it should have type and event
  def create

    # parameters are sent ?
    if not params[:title] and not params[:is_private] and not params[:start_time] and not params[:end_time]
      render json:{ error: " پارامتر ها را کامل کنید " } , status: 402
      return
    end

    # create new event
    event = Event.new(eventParams)

    # define being private or nah
    if event.is_private
      event.is_verified = true
    else
      event.is_verified = false
    end

    # try to save the event
    if event.save
      # fill the events array for sending the information
      # fill the pivot table
      @current_user.event_users.new( event_id: event.id , user_id: @current_user.id ).save

      render json: { event: event , user: @current_user   } , status: :ok
    else
      render json: { error: event.errors } , status: 400
    end
  end




  # =========================== private methods
  private

  # event parameters
  def eventParams
    params.permit( :title , :description , :is_private , :start_time , :end_time , :notification_time , :when_to_repeat , :is_verified , :is_with )
  end

  # type parameters
  def typeParams
    params.permit( :title , :description , :color , :is_verified )
  end





end
