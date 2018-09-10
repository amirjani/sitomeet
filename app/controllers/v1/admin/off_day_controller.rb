class V1::Admin::OffDayController < ApplicationController

  before_action :authenticate_request_admin
  skip_before_action :authenticate_request_admin , :only => []

  # ============================ can can
  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do | exception |
    render json: { alert: exception.message }
  end

  # ============================ index
  def index
    off_day = OffDay.where( user_id: params[:user_id] ).order( "updated_at DESC" ).page( params[:page] || 1 ).per( params[:per] || 10 )
    if User.where( id: params[:user_id] ).last
      if off_day
        render json: off_day , status: 200
      else
        render json: { error: " روز مورد نظر پیدا نشد " } , status: 404
      end
    else
      render json: { error: " متاسفانه کاربر مورد نظر پیدا نشد " } , status: 404
    end
  end

  # ============================ show
  def show
    off_day = OffDay.where( user_id: params[:user_id] ).where( id: params[:id] ).last
    if User.where( id: params[:user_id] ).last
      if off_day
        render json: off_day , status: 200
      else
        render json: { error: " روز مورد نظر پیدا نشد " }, status: 404
      end
    else
      render json: { error: " کاربر مورد نظر پیدا نشد " }, status: 404
    end
  end

  # ============================ delete
  def delete
    off_day = OffDay.where( user_id: params[:user_id] ).where( id: params[:id] ).last
    if User.where( id: params[:user_id] ).last
      if off_day.destroy
        render json: { success: " روز مورد نظر پاک شد " } , status: 200
      else
        render json: { error: " روز مورد نظر پیدا نشد " } , status: 404
      end
    else
      render json: { error: " کاربر مورد نظر پیدا نشد " } , status: 404
    end
  end



end
