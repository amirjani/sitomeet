class V1::TypeForUserController < ApplicationController

  before_action :authenticate_request_user
  skip_before_action :authenticate_request_user, :only => []
  # load_and_authorize_resource

  # ============================ can can
  rescue_from CanCan::AccessDenied do | exception |
    render json: { alert: exception.message }
  end

  # ============================= get user type
  def getUserTypes

    types = []

    @current_user.user_types.each do |type|
      if type.type.is_verified
        types.push(type.type)
      end
    end

    render json: { type: types }
  end

  # ============================= find user type
  def find
    if params[:id]
      type = Type.where( id: params[:id] ).where( is_verified: true ).last
      if type
        render json: { type: type } , status: 200
      else
        render json: { error: " اطلاعات مورد نظر پیدا نشد یا هنوز تایید نشده است " } , status: 404
      end
    end

    if params[:title]
      type = Type.where( title: params[:title] ).where( is_verified: true ).last
      if type
        if type.user_types.last.user_id == @current_user.id
          render json: { type: type } , status: 200
        else
          render json: { error: " شما مجاز به انجام این کار نیستید " } , status: 403
        end
      else
        render json: { error: " اطلاعات مورد نظر شما پیدا نشد! " } , status: 404
      end
    end

  end

  # ============================ create user type
  def create
    # parameters are sent ?
    if not params[:title] and not params[:color]
      render json:{ error: "رنگ یا عنوان را وارد کنید !" } , status: 402
    end
    type = Type.new(createTypeParams)
    if type.save
      @current_user.user_types.new( type_id: type.id , user_id: @current_user.id ).save
      render json: { success: type } , status: :ok
    else
      render json: { error: type.errors } , status: 400
    end
  end

  # ============================ user type update
  def update
    type = @current_user.user_types.where( user_id: @current_user.id ).where( type_id: params[:id] ).last.type
    if type
      type.is_verified = false
      if type.update(createTypeParams)
        render json: { success: type } , status: 200
        return
      else
        render json: { error: " مشکلی در به روز رسانی به وجود آمده است ! " } , status: 400
      end
    else
      render json: { error: " اطلاعات مورد نظر یافت نشد ! " } , status: 404
    end
  end

  # ============================ user type delete
  def delete
    type = Type.where( id: params[:id] ).last
    if type
      if type.delete
        render json: { success: " با موفقیت حذف شد " } , status: 200
      else
        render json: { error: " مشکلی در حذف کردن به وجود آمده است ! " } , status: 400
      end
    else
      render json: { error: " اطلاعات مورد نظر یافت نشد ! " } , status: 404
    end

  end

  # ============================ privates for controller
  private

  # ============================ parameters for creating and updating
  def createTypeParams
    params.permit( :title , :description , :color , :is_verified)
  end

end
