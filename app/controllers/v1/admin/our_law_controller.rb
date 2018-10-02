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
    if  not params[:title] or not params[:description]
      render json: { error: "پارامتر ها را به صورت کامل بفرستید" } , status: 400
      return
    end

    law = @current_user.our_laws.build(ourLawParams)
    if law.save
      render json: law , status: :ok
    else
      render json: law.errors , status: 404
    end
  end

  # ============================= update
  def update
    law = OurLaw.last
    if law.update(ourLawParams)
      render json: law , status: :ok
    else
      render json: law.errors , status: 404
    end
  end

  # ============================= delete
  def delete
    law = OurLaw.last
    if  law
      if law.delete
        render json: { is_deleted: "true" } , status: 200
      else
        render json: { is_deleted: "false" , reason: law.errors } , status: 400
      end
    else
      render json: { error: "قوانین مورد نظر یافت نشد" } , status: 404
    end
  end

  # ============================= private methods
  private

  def ourLawParams
    params.permit(:title , :description)
  end

end
