class V1::EventController < ApplicationController

  before_action :authenticate_request_user
  skip_before_action :authenticate_request_user, :only => []
  # load_and_authorize_resource

  # ============================ can can
  rescue_from CanCan::AccessDenied do | exception |
    render json: { alert: exception.message }
  end



end
