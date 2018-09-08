class V1::Admin::SocialController < ApplicationController

  before_action :authenticate_request_admin
  skip_before_action :authenticate_request_admin , :only => []

  # ============================ can can
  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do | exception |
    render json: { alert: exception.message }
  end

  # ============================ index user social
  def indexUserSocial
    render json: User.where( id: params[:user_id] ).last.socials.page(params[:page] || 1).per(params[:per] || 10) , status: 200
  end

  # ============================ show users Social individual
  def showSocial
    social = Social.where( user_id: params[:user_id] ).where( id: params[:id] ).last
    if social
      render json: social , status: 200
    else
      render json: { error: "شبکه اجتماعی یا کاربر پیدا نشد" } , status: 404
    end
  end


end
