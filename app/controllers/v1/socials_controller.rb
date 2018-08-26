class V1::SocialsController < ApplicationController

  before_action :authenticate_request_user
  skip_before_action :authenticate_request_user, :only => []
  load_and_authorize_resource

  # ================== get socials
  def getSocials
    if @current_user
      socials = @current_user.socials
      render json: { message: socials } , status: 200
    else
      render json: { message: "user not found !" } , status: 404
    end
  end

  # ================== create socials
  def create
    # is user verified ?
    if not @current_user.verified
      render json: { message: "user is not verified" } , status: 400
      return
    end
    # parameters are sent ?
    if not params[:name] or not params[:link]
      render json:{ message: "send parameters completely!" } , status: 404
      return
    end
    # save social media
    socials = @current_user.socials.build(socialParams)
    if socials.save
      render json: { message: socials } , status: :ok
      return
    else
      render json: { message: "there's a problem with saving social media!" } , status: 400
      return
    end
  end

  # ===================== update social
  def update
    social = @current_user.socials.where( id: params[:id]).last
    if social
      if social.update(socialParams)
        render json: { message: social } , status: 202
      else
        render json: { message: "unsuccessful" } , status: 400
      end
    else
      render json: { message: "social not found ! " } , status: 404
    end
  end

  # =============== delete all socials
  def delete_all
    socials = @current_user.socials
    if socials
      if socials.destroy_all
        render json: { message: "social media completely deleted" } , status: 202
      else
        render json: { message: "there's a problem deleting social" } , status: 400
      end
    else
      render json: { message: "socials for this user not found" } , status: 404
    end
  end

  # ================ delete a social
  def delete

    if not params[:id]
      render json: { message: "id is not sent !" } , status: 400
      return
    end

    social = @current_user.socials.where( id: params[:id]).last

    if social
      if social.destroy
        render json: { message: "successfully deleted" } , status: 200
      else
        render json: { message: "can't delete" } , status: 400
      end
    else
      render json: { message: " social not found" } , status: 404
    end

  end

  # =============== private methods
  private

  # =============== parameters to sent
  def socialParams
    params.permit( :name , :link)
  end


end
