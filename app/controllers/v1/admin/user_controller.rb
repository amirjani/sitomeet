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

  # ======================= delete user
  def delete
    User.where( id: params[:id] ).update(status: false ,role: :deleted ,phone_number: "deletedByAdmin")
    render json: { success: "با موفقیت حذف شد" } , status: 200
  end

  # ======================= verify user manually with admin after calling to admins
  def verify
    if User.where( id: params[:id] ).update( verified: true)
      render json: { success: "کاربر به روز رسانی شد" }
    end
  end

  




end
