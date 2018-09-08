Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :v1 , :defaults => {:format => :json} do

    # ============== user's registration and login ( order is important ) =================== #
    post    "user/register"                 , to: "user#register"
    put     "user/verify"                   , to: "user#verification"
    post    "user/token"                    , to: "authentication#authenticateUser"
    post    "user/resend_code"              , to: "user#resendCode"
    post    "user/reset_password"           , to: "user#resetPassword"
    put     "user/update_password"          , to: "user#updatePassword"
    delete  "user/delete_account"           , to: "user#deleteUser"

    # ============== user's profile =================== #
    get     "user/profile"                  , to: "user#profile"
    put     "user/update_profile"           , to: "user#updateProfile"

    # ============== social media =================== #
    get     "user/social_media"             , to: "socials#getSocials"
    post    "user/social_media/create"      , to: "socials#create"
    put     "user/social_media/update/:id"  , to: "socials#update"
    delete  "user/social_media/delete_all"  , to: "socials#delete_all"
    delete  "user/social_media/delete/:id"  , to: "socials#delete"

    # =============== user types =================== #
    get     "user/type"                     , to: "type_for_user#getUserTypes"
    get     "user/type/find"                , to: "type_for_user#find"
    post    "user/type/create"              , to: "type_for_user#create"
    put     "user/type/:id"                 , to: "type_for_user#update"
    delete  "user/type/delete/:id"          , to: "type_for_user#delete"

    # ============== user off days =================== #
    get     "user/off_day"                  , to: "off_day#offDayUser"
    get     "user/off_day/from_to"          , to: "off_day#offDayFromTo"
    post    "user/off_day/create"           , to: "off_day#create"
    put     "user/off_day/update/:id"       , to: "off_day#update"
    delete  "user/off_day/delete/:id"       , to: "off_day#delete"

    # ============== user event =================== #
    post    "user/event/create"              , to: "event#create"

    # ================================== admin routes ============================ #
    namespace :admin , :defaults => {:format => :json} do

      # ============= user event ======================== #
      get     "users"                           , to: "user#index"
      get     "users/active"                    , to: "user#indexActiveUser"
      get     "users/deleted"                   , to: "user#indexDeletedUser"
      delete  "user/:id/delete"                 , to: "user#delete"
      put     "user/:id/verify"                 , to: "user#verify"

      # ============== national event =================== #
      get     "national_event"                , to: "national_event#index"
      get     "national_event/mySaved"        , to: "national_event#userIndex"
      get     "national_event/time_between"   , to: "national_event#eventsInMonth"
      post    "national_event/create"         , to: "national_event#create"
      put     "national_event/update/:id"     , to: "national_event#update"
      delete  "national_event/delete/:id"     , to: "national_event#delete"

      # ============== user social index ================= #
      get     "user/:user_id/social"               , to: "social#indexUserSocial"

    end

  end

end
