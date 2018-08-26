class AuthenticateUser
  # A simple, standardized way to build and use Service Objects (aka Commands) in Ruby
  prepend SimpleCommand

  # initialize user with phone number and password
  def initialize(phone_number , password)
    @phone_number = phone_number
    @password     = password
  end

  # encode user id
  def call
    encode( user_id: user.id ) if user
  end

  private
  attr_accessor :phone_number, :password

  # define user
  def user
    user = User.find_by(phone_number: phone_number)
    return user if user && user.authenticate(password)
    errors.add :user_authentication, 'invalid credentials'
    nil
  end

  # define encode
  def encode(payload, exp = 5.month.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  #define decode
  def decode(token)
    body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
    HashWithIndifferentAccess.new body
  rescue
    nil
  end





end