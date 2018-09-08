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

  # ============================ delete social
  def delete
    if Social.where( user_id: params[:user_id] ).where( id: params[:id] ).last.destroy
      render json: { success: "شبکه ی مورد نظر حذف شد" } , status: 200
    else
      render json: { error: " شبکه یا کاربر مورد نظر یافت نشد " } , status: 404
    end
  end

  # ============================ update social
  def update
    social = Social.where( user_id: params[:user_id] ).where( id: params[:id] ).last
    if social
      if social.update(updateParams)
        render json: social
      else
        render json: { error: social.errors } ,status: 404
      end
    else
      render json: { error: " شبکه یا کاربر مورد نظر یافت نشد " } , status: 404
    end
  end

  # ============================ private in this controller
  private

  def updateParams
    params.permit( :name , :link )
  end

end
