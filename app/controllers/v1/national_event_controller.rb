class V1::NationalEventController < ApplicationController

  before_action :authenticate_request_user
  skip_before_action :authenticate_request_user, :only => []
  load_and_authorize_resource

  # ============================ can can
  rescue_from CanCan::AccessDenied do | exception |
    render json: { alert: exception.message }
  end

  # ============================ show today national event
  def todayEvent
    event = NationalEvent.where(date: Date.today ).all
    if event
      render json: event  , status:200
    else
      render json: { error: "رویداد ملی ای پیدا نشد" } , status: 200
    end
  end

end
