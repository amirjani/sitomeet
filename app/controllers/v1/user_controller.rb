class V1::UserController < ApplicationController

  # ====================== validations
  before_action :authenticate_request_user
  skip_before_action :authenticate_request_user, :except => [ :profile, :updatePassword , :updateProfile , :deleteUser , :uploadProfilePicture, :insertContactNumbers, :getContacts]

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
    if not params[:first_name] or not params[:family_name] or not params[:phone_number] or not params[ :sex ] or not params[:password] or not params[:birthday]
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
      nc_authorization_key = register_to_nc
      user.update(nc_authorization_key: nc_authorization_key)
      for i in 0..4
       userColorEvent = UserColorEvent.new
       userColorEvent.user_id = user.id
       userColorEvent.event_color = i 
       userColorEvent.event_type = i 
       userColorEvent.save
      end
             
      text =  " سلام #{ user.first_name + ' ' + user.family_name } عزیز \n  به سامانه ی سیت و میت خوش آمدید \n کد عبور شما #{ code } است  \n سامانه ی سیت و می"

      send_sms( user.phone_number , text)

      render json: user , status: :created
    else
      render json: { message: user.errors }, status: :unprocessable_entity
    end
  end

  # ======================= verify the user
  def verification

    # code is not sent
    unless params[:code]
      render json: { message: " اطلاعات را به صورت کامل بفرستید " } , status:400
      return
    end

    # code is sent and user found
    if params[:code]

      user = User.where(verification_code: params[:code]).where(phone_number: params[:phone_number]).first

      if user and not user.verified

        if Time.now > user.verification_code_sent_at + 10.minute
          render json: { message: " کد ارسالی شما باطل شده است " } , status: 403

        else
          user.verified = true

          if user.save
            render json: { message: " کاربر تایید شد " } , status: 200

          else
            render json: { message: user.errors.full_messages } , status: 400
          end
        end

      elsif user&.verified
        render json: { message: " شما در حال حاضر تایید شده هستید " } , status: 200
      else
        render json: { message: " کد را اشتباه وارد کردید " } , status: 400
      end
    end
  end

  # ======================= resend the code if time has been ended
  def resendCode
    user = User.where(phone_number: params[:phone_number]).first

    code = rand(1000..9999)

    unless user
      render json: { message: " کاربر با شماره تلفن مورد نظر وجود ندارد " } , status: 404
      return
    end

    user.verification_code = code
    user.verification_code_sent_at = Time.now

    if user.save
      text = " #{ user.first_name } #{ user.family_name  } عزیز \nکد ورود مجدد شما به سامانه سیت و میت #{ user.verification_code } است \nسامانه سیت و میت "

      send_sms(user.phone_number , text)

      render json: { message: " کد فرستاده شد " } , status: 200

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

        text = "#{ user.first_name + ' ' + user.family_name } عزیز\nکد عبور شما #{ code } است\nلطفا پس از ورود مجدد ، رمز خود را تغییر دهید\nسامانه سیت و میت"
        user.password_digest = BCrypt::Password.create(code)
        if user.save
          send_sms(user.phone_number , text)
          render json: { message: " پیام ارسال شد و کد عبور شما تغییر یافت " } , status: 200
        else
          render json: { message: " پیام ارسال نشد ، به واحد پشتیبانی خبر دهید. " } , status: 410
        end
      else
        render json: { message: user.errors } , status: 403
      end
    else
      render json: { message: "کاربر پیدا نشد" } , status: 404
    end
  end

  # ======================= get user profile
  def profile
    if @current_user
      render json: @current_user , status: 200
    else
      render json: { message: " توکن شما یافت نشد! " } , status: 200
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
      render json: { message: " رمز عبور گذشته به درستی وارد نشده است " } , status: 400
      return
    end

    unless params[:newPassword] == params[:newPasswordConfirmation]
      render json: { message: " رمز عبور ها همخوانی ندارند " } , status: 400
    end

    user.password = params[:newPassword]
    if user.forget_password
      user.forget_password = false
    end

    if user.save
      render json: { message: " رمز عبور با موفقیت تغییر یافت " } , status: 400
    else
      render json: { message: user.errors } , status: :unprocessable_entity
    end
  end

  # ======================= upload profile picture
  def uploadProfilePicture
    if @current_user.update(profilePicture)
      Rails.logger.info "****************#{@current_user.photo.url}****"
      render json: @current_user , status: 200
    else
      render json: { message: @current_user.errors } , status: 404
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
        text = " #{ user.first_name + ' ' + user.family_name } عزیز \nکد ورود مجدد شما به سامانه سیت و میت #{ user.verification_code } است \nسامانه سیت و میت "
        send_sms(@current_user.phone_number,text)
        render json: { message: " شماره تماس تغییر یافت و کد تایید مجدد فرستاده شد " } , status: :ok
        return
      end
    render json: { message: " به روز راستی شد " } , status: :ok
    end
  end

  # ======================= delete user
  def deleteUser
    @current_user.update(status: false ,role: :deleted ,phone_number: "#{@current_user.phone_number}*deleted*#{rand(11.99)}")
    render json: { message: "با موفقیت حذف شد" }, status: 200
  end


  # ======================= insert contact numbers
  def insertContactNumbers
    @current_user.update(contacts: params[:contacts])
    render json: {message: "ok"}
  end  

  # ======= get contact
  def getContacts
    result = []
    @current_user.contacts.each do |cn|
      user = User.where("phone_number = ?", cn).last
      if user
	object = {id: user.id,phone_number: cn,photo: user.photo}
	result.push(object)
      end
    end
    render json: result
  end


  def getNotificationCenterInfo
    ""#render json: {authorization_key: @current_user.nc_authorization_key}
  end

  # ======================= private for this controller
  private

  # ======================= register parameters
  def register_params
    params.permit( :first_name , :family_name , :phone_number , :password , :sex , :birthday , :email)
  end

  # ======================= update parameters
  def updateParams
    params.permit( :first_name , :family_name , :phone_number , :sex , :birthday , :bio , :username , :email , :location , :is_private , :photo)
  end

  # ======================= upload profile
  def profilePicture
    params.permit( :photo)
  end

  # ======================= send sms
  def send_sms(to,text)
    url = "http://www.0098sms.com/sendsmslink.aspx?FROM=30005883333335&TO=#{to}&TEXT=#{text}&USERNAME=xsms6874&PASSWORD=33947786&DOMAIN=0098"
    url = URI.encode(url)
    RestClient.get(url)
  end

  def register_to_nc
    authorization_key = ""
    response = RestClient.post 'http://31.184.135.239/api/v1/player', {api_key: "#{nd_android_api_key}"}
    if response.code == 200
      authorization_key = JSON.parse(response.body)["authorization_key"]
    end
    authorization_key
  end
end

