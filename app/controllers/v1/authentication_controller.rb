class V1::AuthenticationController < ApplicationController

  # is user authenticate or not
  def authenticateUser
    user = User.where( :phone_number => params[:phone_number] ).first

    # find user and if not present return 404 status code
    unless user
      render json: { message:" user not found " } , status: 404
      return
    end

    # get to a user token
    command = AuthenticateUser.call(params[:phone_number] , params[:password])
    # find user by it's phone number
    user = User.find_by(phone_number: params[:phone_number])

    # if token is correctly accessed
    if command.success?
      if user.verified == false
        render json: { message: "account is not verified" } , status: 401
        return
      end
      if user.status == true
        render json: { token: command.result}
      end
    elsif user.status == false
      render json: { message: "access denied" } , status: 403
    else
      render json: { message: "wrong" } , status: 401
    end
  end
end