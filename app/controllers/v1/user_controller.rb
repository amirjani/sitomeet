class V1::UserController < ApplicationController

  # ====================== validations
  before_action :authenticate_request_user
  skip_before_action :authenticate_request_user, :except => [ :profile, :updatePassword , :updateProfile , :deleteUser]
  load_and_authorize_resource
  skip_authorize_resource :only => [ :register , :verification , :deleteUser  ]

  # ======================= can can
  rescue_from CanCan::AccessDenied do | exception |
    render json: { alert: exception.message }
  end

  # ======================= register a user
  def register

    # check if the password and password confirmation is same
    if params[:password] != params[:password_confirmation]
      # 409 status code is for conflict
      render json: { message: " رمز عبور ها همخوانی ندارند " } , status: 409
      return
    end

    # check user is subscribed or not
    if User.find_by(phone_number: params[:phone_number])
      render json: { message: "اطلاعات شما در حال حاضر در سامانه سیت و میت حضور دارد " } , status: 422
      return
    end

    # check the fields is filled or not
    if not params[:name] or not params[:phone_number] or not params[ :sex ] or not params[:password] or not params[:birthday]
      render json: { message: " اطلاعات را به صورت کامل وارد کنید " } , status: 400
      return
    end

    #register user
    user = User.new(register_params)
    user.verified = false
    user.status = true
    user.forget_password = false

    code = rand(1000..9999)
    user.verification_code = code

    user.verification_code_sent_at = Time.now

    if user.save
      text =  " سلام #{ user.name } عزیز \n  به سامانه ی سیت و میت خوش آمدید \n کد عبور شما #{ code } است  \n سامانه ی سیت و میت"

      send_sms(user.phone_number , text)

      render json: { message: " کاربر با موفقیت ساخته شد " } , status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  # ======================= verify the user
  def verification

    # code is not sent
    unless params[:code]
      render json: { message: "code parameter is missed" } , status:400
      return
    end

    # code is sent and user found
    if params[:code]
      user = User.where(verification_code: params[:code]).where(phone_number: params[:phone_number]).first
      if user and not user.verified
        if Time.now > user.verification_code_sent_at + 60.minute
          render json: { message: "verification code has been expired , please request a new one" } , status: 403
        else
          user.verified = true
          if user.save
            render json: { message: "successfully verified" } , status: 200
          else
            render json: { message: user.errors.full_messages } , status: 400
          end
        end
    elsif user and user.verified
      render json: { message: "already registered ! login" } , status: 200
    else
      render json: { message: "verification code is incorrect" } , status: 400
      end
    end
  end

  # ======================= resend the code if time has been ended
  def resendCode
    user = User.where(phone_number: params[:phone_number]).first
    code = rand(1000..9999)

    unless user
      render json: { message: "user not found" } , status: 404
      return
    end

    user.verification_code = code
    user.verification_code_sent_at = Time.now
    if user.save
      text = " #{user.name} عزیز کد ورود مجدد شما #{user.verification_code} می باشد "
      send_sms(user.phone_number , text)
      render json: { message: "verification code is sent" } , status: 200
    else
      render json: { message: user.errors.full_messages } , status: :unprocessable_entity
    end
  end

  # ======================= reset password
  def resetPassword
    user = User.where(phone_number: params[:phone_number]).first
    if user
      if user.update(forget_password: true)
        code = rand(1000..9999)
        text = " رمز شما #{code} است "
        user.password_digest = BCrypt::Password.create(code)
        if user.save
          send_sms(user.phone_number , text)
          render json: { message: "message sent and password has been successfully changed" } , status: 200
        else
          render json: { message: "password not sent" } , status: 410
        end
      else
        render json: { message: "password can't changed" } , status: 403
      end
    else
      render json: { message: "user not found" } , status: 404
    end
  end

  # ======================= get user profile
  def profile
    if @current_user
      render json: { message: @current_user } , status: 200
    else
      render json: { message: "invalid user token" } , status: 200
    end
  end

  # ======================= updating pasword
  def updatePassword
    user = @current_user

    if not params[:oldPassword]
      render json: { message: "oldPassword is not passed" } , status: 422
      return
    elsif not params[:newPassword]
      render json: { message: "newPassword is not passed" } , status: 422
      return
    elsif not params[:newPasswordConfirmation]
      render json: { message: "newPasswordConfirmation is not passed" } , status: 422
      return
    end

    oldPassword = params[:oldPassword]
    newPassword = params[:newPassword]

    unless user.authenticate(oldPassword)
      render json: { message: "old password is incorrect" } , status: 400
      return
    end

    unless newPassword == params[:newPasswordConfirmation]
      render json: { message: "password doesn't match" } , status: 400
    end

    user.password = params[:newPassword]
    if user.forget_password == true
      user.forget_password = false
    end
    if user.save
      render json: { message: "password successfully changed !" } , status: 400
    else
      render json: user.errors , status: :unprocessable_entity
    end
  end


  # ======================= update profile
  def updateProfile
    currentPhoneNumber = @current_user.phone_number
    if @current_user.update(updateParams)
    unless currentPhoneNumber == @current_user.phone_number
      current_user.update(verified: false)
      code = rand(1000..9999)
      current_user.verification_code = code
      current_user.verification_code_sent_at = Time.now
      text = "کد ورود مجدد شما #{code} می باشد"
      send_sms(@current_user.phone_number,text)
      render json: { message: "phone number is changed and confirmation sent" } , status: :ok
      return
    end
    render json: { message: "updated" } , status: :ok
    end
  end

  # ======================= delete user
  def deleteUser
    @current_user.update(status: false ,role: :deleted ,phone_number: "#{@current_user.phone_number}*deleted*#{rand(11.99)}")
    render json: { message: "successfully deleted" }, status: 200
  end

  # ======================= private for this controller
  private

  def register_params
    params.permit( :name , :phone_number , :password , :sex , :birthday)
  end

  def updateParams
    params.permit(:name , :phone_number , :sex , :birthday , :bio , :username , :email , :location , :is_private , :photo)
  end

  def send_sms(to,text)
    url = "http://www.0098sms.com/sendsmslink.aspx?FROM=30005883333335&TO=#{to}&TEXT=#{text}&USERNAME=xsms6874&PASSWORD=33947786&DOMAIN=0098"
    url = URI.encode(url)
    body = RestClient.get(url)
  end

end
