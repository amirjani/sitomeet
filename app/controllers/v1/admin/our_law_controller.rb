class V1::Admin::OurLawController < ApplicationController

  before_action :authenticate_request_admin
  skip_before_action :authenticate_request_admin , :only => []

  # ============================ can can
  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do | exception |
    render json: { alert: exception.message }
  end

  # ============================ show
  def show
    render json: OurLaw.last , status: 200
  end

  # =========================== store
  def store

  end

end
