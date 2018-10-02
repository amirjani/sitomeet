class V1::OurLawController < ApplicationController

  load_and_authorize_resource

  # ============================ can can
  rescue_from CanCan::AccessDenied do | exception |
    render json: { alert: exception.message }
  end

  # ======================= show
  def show
    law = OurLaw.last
    if law
      render json: OurLaw.last , status: 200
    else
      render json: { error: "قوانین مورد نظر یافت نشد" } , status: 404
    end
  end

end
