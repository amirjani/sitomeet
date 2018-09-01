class V1::NationalEventController < ApplicationController

  before_action :authenticate_request_user
  skip_before_action :authenticate_request_user, :only => []

  # ============================ can can
  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do | exception |
    render json: { alert: exception.message }
  end

  # ============================= get national_events
  def index

     # if date sent
     if params[ :date ]
       searchWithDate
       return
     end

     #  if is day off only passed
     if params[ :is_day_off ]
       searchWithDayOff
       return
     end

    # only page and per sent
    if params[ :page ] and params[ :per ]
      searchWithPagination
      return
    end

     events = NationalEvent.order( "updated_at DESC" ).all
     render json: { message: events } , status: 302
  end

  # ============================= user saved national event
  def userIndex
    events = @current_user.national_event.order(" updated_at DESC ").page(params[:page]).per(params[:per])
    render json: { message: events } , status: 302
  end

  # ============================= create national event
  def create
    # parameters are sent ?
    if not params[:date] or not params[:title] or not params[:is_day_off]
      render json:{ message: "پارامتر ها را به صورت کامل ارسال کنید" } , status: 402
      return
    end
    # save national event
    event = @current_user.national_event.build(nationalEventParams)
    if event.save
      render json: { message: event } , status: :ok
    else
      render json: { message: event.errors } , status: 400
    end
  end

  # ============================= update
  def update
    event = @current_user.national_event.where( id: params[:id]).last
    if event
      if event.update(nationalEventParams)
        render json: { message: event } , status: 200
      else
        render json: { message: event.errors } , status: 400
      end
    else
      render json: { message: " رویداد عمومی یافت نشد " } , status: 404
    end
  end

  # ============================= delete
  def delete
    event = NationalEvent.where( id: params[:id]).last
    if event.delete
      render json: { successfull: "رویداد عمومی حذف شد" } , status: 200
    end
  end

  # ============================= events between 2 date
  def eventsInMonth
    # if start and end time sent
    if params[ :start ] and params[ :end ]
      event = NationalEvent.where( date: params[:start]..params[:end] ).order( "date" ).all
      render json: { success: event } , status: 302
    else
      render json: { error: "پارامتر ها را کامل پاس دهید" } , status: :not_found
    end
  end


  # ================================ PRIVATE TO THIS CONTROLLER ========================================
  private

  # ============================= parameters to sent
  def nationalEventParams
    params.permit( :date , :title , :description , :is_day_off)
  end

  # ============================= define search with date
  def searchWithDate
      # if day is off and parameters of page and per passed
      if params[ :page ] and params[:per] and params[ :is_day_off ] == true or params[ :is_day_off ] == "true"
        events = NationalEvent.where( date: params[:date] ).where( is_day_off: true ).order( "updated_at DESC" ).page(params[:page]).per(params[:per])
        render json: { message: events } , status: 302
        return

        # if day is off and parameters of page and per =>not<= passed
      elsif params[ :is_day_off ] == true or params[ :is_day_off ] == "true"
        events = NationalEvent.where( date: params[:date] ).where( is_day_off: true ).order( "updated_at DESC" ).all
        render json: { message: events } , status: 302
        return

        # if day is on and parameters of page and per passed
      elsif params[ :page ] and params[:per] and params[ :is_day_off ] == false or params[ :is_day_off ] == "false"
        events = NationalEvent.where( date: params[:date] ).where( is_day_off: false ).order( "updated_at DESC" ).page(params[:page]).per(params[:per])
        render json: { message: events } , status: 302
        return

        # if day is on and parameters of page and per =>not<= passed
      elsif params[ :is_day_off ] == false or params[ :is_day_off ] == "false"
        events = NationalEvent.where( date: params[:date] ).where( is_day_off: false ).order( "updated_at DESC" ).all
        render json: { message: events } , status: 302
        return
      end
      # date pass and params and per
      if params[:page] and params[:per]
        events = NationalEvent.where(date: params[:date]).order( "updated_at DESC" ).page(params[:page]).per(params[:per])
        render json: { message: events } , status: 302
        return
      end

      # date pass only
      events = NationalEvent.where( date: params[:date]).order( "updated_at DESC" ).all
      render json: { message: events } , status: 302
  end

  # ============================= define search with is day off
  def searchWithDayOff
    if params[:is_day_off] == true or params[:is_day_off] == "true"
      #  if page and per parameters were available
      if params[:page] and params[:page]
        events = NationalEvent.where( is_day_off: true ).order( "updated_at DESC" ).page(params[:page]).per(params[:per])
        render json: { message: events } , status: 302
        return
      else

        # if only day off matters
        events = NationalEvent.where( is_day_off: true ).order( "updated_at DESC" ).all
        render json: { message: events } , status: 302
        return
      end
      #   day is on
    elsif params[:is_day_off] == false or params[:is_day_off] == "false"

      #  page and per sent
      if params[:page] and params[:page]
        events = NationalEvent.where( is_day_off: false ).order( "updated_at DESC" ).page(params[:page]).per(params[:per])
        render json: { message: events } , status: 302
        return
      else

        # if only day on matters
        events = NationalEvent.where( is_day_off: false ).order( "updated_at DESC" ).all
        render json: { message: events } , status: 302
        return
      end
    end
  end

  # ============================= define search only with pagination
  def searchWithPagination
    events = NationalEvent.order( "updated_at DESC" ).page(params[:page]).per(params[:per])
    render json: { message: events } , status: 302
  end

end
