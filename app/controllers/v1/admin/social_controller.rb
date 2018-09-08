class V1::Admin::SocialController < ApplicationController

  before_action :authenticate_request_admin
  skip_before_action :authenticate_request_admin , :only => []

  # ============================ can can
  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do | exception |
    render json: { alert: exception.message }
  end

  # ============================
  def indexUserSocial
    render json: User.where( id: params[:user_id] ).last.socials.page(params[:page] || 1).per(params[:per] || 10)
  end

end
