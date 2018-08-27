class V1::OffDayController < ApplicationController

  before_action :authenticate_request_user
  skip_before_action :authenticate_request_user, :only => []
  load_and_authorize_resource

  # ============================ can can
  rescue_from CanCan::AccessDenied do | exception |
    render json: { alert: exception.message }
  end

  # ============================ get all off day of a user
  def offDayUser
    render json: { off_days: @current_user.off_days.page(params[:page]).per(params[:per]) }
  end

  # ============================ userDayOfFromDateToDate
  def offDayFromTo
    # if start and end time sent
    if params[ :from ] and params[ :to ]
      day = @current_user.off_days.where( date: params[:from]..params[:to] ).order( "date" ).all
      render json: { day: day } , status: 302
    else
      render json: { error: "پارامتر ها را کامل پاس دهید" } , status: :not_found
    end
  end

  # ============================ create off day
  def create
    # parameters are sent ?
    unless params[:date]
      render json: {message: " پارامتر ها به صورت کامل فرستاده نشده اند. "}, status: 402
      return
    end

    # save national event
    day = @current_user.off_days.build( offDayParams )
    if day.save
      render json: { day: day } , status: :ok
    else
      render json: { error: day.errors } , status: 400
    end
  end

  # ============================ update off day
  def update
    day = @current_user.off_days.where( id: params[:id] ).last
    if day
      if day.update( offDayParams )
        render json: { day: day } , status: 200
      else
        render json: { error: day.errors } , status: 400
      end
    else
      render json: { error: " روز مورد نظر یافت نشد. " } , status: 404
    end
  end

  # ============================ delete off day
  def delete
    day = OffDay.where( id: params[:id] ).last
    if day.delete
      render json: { successfull: " با موفقیت حذف شد " } , status: 200
    else
      render json: { error: day.errors }
    end
  end


  # =========================== private methods
  private

  def offDayParams
    params.permit( :date , :description )
  end


end
