class V1::Admin::UserController < ApplicationController

  # ====================== validations
  before_action :authenticate_request_admin
  skip_before_action :authenticate_request_admin , :only => []
  load_and_authorize_resource

  # ======================= can can
  rescue_from CanCan::AccessDenied do | exception |
    render json: { alert: exception.message }
  end

  # ======================= show all user for admin
  def index
    page = params[:page] || 1
    per = params[:per] || 10

    render json: User.page(page).per(per)
  end

  

end
