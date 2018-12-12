class V1::AuthenticationController < ApplicationController

  # is user authenticate or not
  def authenticateUser
    user = User.where( :phone_number => params[:phone_number] ).first

    # find user and if not present return 404 status code
    unless user
      render json: { message:" کاربر پیدا نشد " } , status: 404
      return
    end

    # get to a user token
    command = AuthenticateUser.call(params[:phone_number] , params[:password])
    # find user by it's phone number
    user = User.find_by(phone_number: params[:phone_number])

    # if token is correctly accessed
    if command.success?

      unless user.verified
        render json: user , status: 401
        return
      end

      if user.status
        render json: { token: command.result}
      end

    elsif !user.status
      render json: { message: " شما به این بخش دسترسی ندارید " } , status: 403
    else
      render json: { message: " اشتباه " } , status: 401
    end
  end
end