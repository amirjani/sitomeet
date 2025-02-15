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

    render json: User.page(page).per(per) , status: 200
  end

  # ======================= delete user
  def delete
    User.where( id: params[:id] ).update(status: false ,role: :deleted ,phone_number: "deletedByAdmin")
    render json: { success: "با موفقیت حذف شد" } , status: 200
  end

  # ======================= verify user manually with admin after calling to admins
  def verify
    if User.where( id: params[:id] ).update( verified: true)
      render json: { success: "کاربر به روز رسانی شد" } , status: 200
    end
  end

  # ======================= index deleted user
  def indexDeletedUser
    render json: User.where( "phone_number LIKE ?" , "%deletedByAdmin%" ).page(params[:page] || 1).per(param[:per] || 10)
  end

  # ======================= index active users
  def indexActiveUser
    render json: User.where( "phone_number NOT LIKE ?" ,  "%deletedByAdmin%" ).where( "verified" , true ).page(params[:page] || 1).per(params[:per] || 10)
  end





end
