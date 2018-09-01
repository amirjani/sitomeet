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
      render json: { error: " رمز عبور ها همخوانی ندارند " } , status: 409
      return
    end

    # check user is subscribed or not
    if User.find_by(phone_number: params[:phone_number])
      render json: { conflict: "اطلاعات شما در حال حاضر در سامانه سیت و میت حضور دارد " } , status: 422
      return
    end

    # check the fields is filled or not
    if not params[:name] or not params[:phone_number] or not params[ :sex ] or not params[:password] or not params[:birthday]
      render json: { error: " اطلاعات را به صورت کامل وارد کنید " } , status: 400
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

      render json: { success: " کاربر با موفقیت ساخته شد " } , status: :created
    else
      render json: { error:user.errors }, status: :unprocessable_entity
    end
  end

  # ======================= verify the user
  def verification

    # code is not sent
    unless params[:code]
      render json: { error: " اطلاعات را به صورت کامل بفرستید " } , status:400
      return
    end

    # code is sent and user found
    if params[:code]

      user = User.where(verification_code: params[:code]).where(phone_number: params[:phone_number]).first

      if user and not user.verified

        if Time.now > user.verification_code_sent_at + 10.minute
          render json: { error: " کد ارسالی شما باطل شده است " } , status: 403

        else
          user.verified = true

          if user.save
            render json: { success: " کاربر تایید شد " } , status: 200

          else
            render json: { error: user.errors.full_messages } , status: 400
          end
        end

      elsif user&.verified
        render json: { error: " شما در حال حاضر تایید شده هستید " } , status: 200
      else
        render json: { error: " کد را اشتباه وارد کردید " } , status: 400
      end
    end
  end

  # ======================= resend the code if time has been ended
  def resendCode
    user = User.where(phone_number: params[:phone_number]).first

    code = rand(1000..9999)

    unless user
      render json: { error: " کاربر با شماره تلفن مورد نظر وجود ندارد " } , status: 404
      return
    end

    user.verification_code = code
    user.verification_code_sent_at = Time.now

    if user.save
      text = " #{ user.name } عزیز \nکد ورود مجدد شما به سامانه سیت و میت #{ user.verification_code } است \nسامانه سیت و میت "

      send_sms(user.phone_number , text)

      render json: { success: " کد فرستاده شد " } , status: 200

    else
      render json: { error: user.errors.full_messages } , status: :unprocessable_entity
    end

  end

  # ======================= reset password
  def resetPassword

    user = User.where(phone_number: params[:phone_number]).first

    if user
      if user.update(forget_password: true)

        code = rand(1000..9999)

        text = "#{ user.name } عزیز\nکد عبور شما #{ code } است\nلطفا پس از ورود مجدد ، رمز خود را تغییر دهید\nسامانه سیت و میت"
        user.password_digest = BCrypt::Password.create(code)
        if user.save
          send_sms(user.phone_number , text)
          render json: { success: " پیام ارسال شد و کد عبور شما تغییر یافت " } , status: 200
        else
          render json: { error: " پیام ارسال نشد ، به واحد پشتیبانی خبر دهید. " } , status: 410
        end
      else
        render json: { error: user.errors } , status: 403
      end
    else
      render json: { error: "کاربر پیدا نشد" } , status: 404
    end
  end

  # ======================= get user profile
  def profile
    if @current_user
      render json: { success: @current_user } , status: 200
    else
      render json: { error: " توکن شما یافت نشد! " } , status: 200
    end
  end

  # ======================= updating password
  def updatePassword


    if not params[:oldPassword] or not params[:newPassword] or not params[:newPasswordConfirmation]
      render json: { message: " رمز عبور گذشته خود را وارد کنید " } , status: 422
      return
    end

    user = @current_user


    unless user.authenticate(params[:oldPassword])
      render json: { error: " رمز عبور گذشته به درستی وارد نشده است " } , status: 400
      return
    end

    unless params[:newPassword] == params[:newPasswordConfirmation]
      render json: { error: " رمز عبور ها همخوانی ندارند " } , status: 400
    end

    user.password = params[:newPassword]
    if user.forget_password
      user.forget_password = false
    end

    if user.save
      render json: { success: " رمز عبور با موفقیت تغییر یافت " } , status: 400
    else
      render json: { error: user.errors } , status: :unprocessable_entity
    end
  end


  # ======================= update profile
  def updateProfile
    lastPhoneNumber = @current_user.phone_number
    if @current_user.update(updateParams)
      unless lastPhoneNumber == @current_user.phone_number
        current_user.update(verified: false)
        code = rand(1000..9999)
        current_user.verification_code = code
        current_user.verification_code_sent_at = Time.now
        text = " #{ user.name } عزیز \nکد ورود مجدد شما به سامانه سیت و میت #{ user.verification_code } است \nسامانه سیت و میت "
        send_sms(@current_user.phone_number,text)
        render json: { success: " شماره تماس تغییر یافت و کد تایید مجدد فرستاده شد " } , status: :ok
        return
      end
    render json: { success: " به روز راستی شد " } , status: :ok
    end
  end

  # ======================= delete user
  def deleteUser
    @current_user.update(status: false ,role: :deleted ,phone_number: "#{@current_user.phone_number}*deleted*#{rand(11.99)}")
    render json: { message: "successfully deleted" }, status: 200
  end

  # ======================= private for this controller
  private

  # ======================= register parameters
  def register_params
    params.permit( :name , :phone_number , :password , :sex , :birthday)
  end

  # ======================= update parameters
  def updateParams
    params.permit(:name , :phone_number , :sex , :birthday , :bio , :username , :email , :location , :is_private , :photo)
  end

  # ======================= send sms
  def send_sms(to,text)
    url = "http://www.0098sms.com/sendsmslink.aspx?FROM=30005883333335&TO=#{to}&TEXT=#{text}&USERNAME=xsms6874&PASSWORD=33947786&DOMAIN=0098"
    url = URI.encode(url)
    RestClient.get(url)
  end

end
