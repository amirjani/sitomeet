class V1::TypeForUserController < ApplicationController

  before_action :authenticate_request_user
  skip_before_action :authenticate_request_user, :only => []
  # load_and_authorize_resource

  # ============================ can can
  rescue_from CanCan::AccessDenied do | exception |
    render json: { alert: exception.message }
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
    render json: { type: type }
    return
    if type
      if event.update(nationalEventParams)
        render json: { message: event } , status: 200
      else
        render json: { message: "there's a problem" } , status: 400
      end
    else
      render json: { message: "  " } , status: 404
    end
  end

  # ============================= privates for controller
  private

  def createTypeParams
    params.permit( :title , :description , :color , :is_verified)
  end

end
