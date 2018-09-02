class ApplicationController < ActionController::API
  # protect_from_forgery
  # protect_from_forgery with: :null_session
  before_action :set_headers
  # before_action :authenticate_request_user


  attr_reader :current_user

  def set_headers
    puts 'ApplicationController.set_headers'
    if request.headers["HTTP_ORIGIN"]
      headers['Access-Control-Allow-Origin'] = request.headers["HTTP_ORIGIN"]
      headers['Access-Control-Expose-Headers'] = 'ETag'
      headers['Access-Control-Allow-Methods'] = 'GET, POST, PATCH, PUT, DELETE, OPTIONS, HEAD'
      headers['Access-Control-Allow-Headers'] = '*,x-requested-with,Content-Type,If-Modified-Since,If-None-Match,Auth-User-Token'
      headers['Access-Control-Max-Age'] = '86400'
      headers['Access-Control-Allow-Credentials'] = 'true'
    end
  end

  def authenticate_request_user
    @current_user = AuthorizeApiUser::call(request.headers).result
    unless @current_user
      render json: { error: 'Not Authorized. please signin' }, status: 401
      return
    end
  end

end
