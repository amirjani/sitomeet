class V1::SocialsController < ApplicationController

  before_action :authenticate_request_user
  skip_before_action :authenticate_request_user, :only => []
  load_and_authorize_resource

  # ================== get socials
  def getSocials
    if @current_user
      socials = @current_user.socials
      render json: socials , status: 200
    else
      render json: { message: "کاربر پیدا نشد" } , status: 404
    end
  end

  # ================== create socials
  def create

    # is user verified ?
    unless @current_user.verified
      render json: {error: " نام کاربری شما هنوز فعال نشده است "}, status: 400
      return
    end

    # parameters are sent ?
    if not params[:name] or not params[:link]
      render json:{ message: " پارامتر ها به صورت کامل پر کنید " } , status: 404
      return
    end

    # save social media
    socials = @current_user.socials.build(socialParams)
    if socials.save
      render json: socials , status: :ok
    else
      render json: socials.errors , status: 400
    end
  end

  # ===================== update social
  def update
    social = @current_user.socials.where( id: params[:id]).last
    if social
      if social.update(socialParams)
        render json: social  , status: 202
      else
        render json: social.errors, status: 400
      end
    else
      render json: social.errors , status: 404
    end
  end

  # =============== delete all socials
  def delete_all
    socials = @current_user.socials
    if socials
      if socials.destroy_all
        render json: { success: " تمامی شبکه های اجتماهی حذف شدند " } , status: 202
      else
        render json: socials.errors , status: 400
      end
    else
      render json: { error: " شبکه های اجتماعی کاربر مورد نظر یافت نشد " } , status: 404
    end
  end

  # ================ delete a social
  def delete

    unless params[:id]
      render json: {message: " اطلاعات را به صورت کامل بفرستید "}, status: 400
      return
    end

    social = @current_user.socials.where( id: params[:id]).last

    if social
      if social.destroy
        render json: { message: " شبکه اجتماعی حذف شد " } , status: 200
      else
        render json: social.errors , status: 400
      end
    else
      render json: { message: " شبکه اجتماعی مورد نظر یافت نشد " } , status: 404
    end

  end

  # =============== private methods
  private

  # =============== parameters to sent
  def socialParams
    params.permit( :name , :link)
  end


end
