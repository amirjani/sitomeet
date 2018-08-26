Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :v1 , :defaults => {:format => :json} do


    # user's registration and login ( order is important )
    post    "user/register"                 , to: "user#register"
    put     "user/verify"                   , to: "user#verification"
    post    "user/token"                    , to: "authentication#authenticateUser"
    post    "user/resend_code"              , to: "user#resendCode"
    post    "user/reset_password"           , to: "user#resetPassword"
    put     "user/update_password"          , to: "user#updatePassword"
    delete  "user/delete_account"           , to: "user#deleteUser"


    # user's profile
    get     "user/profile"                  , to: "user#profile"
    put     "user/update_profile"           , to: "user#updateProfile"


    # social media
    get     "user/social_media"             , to: "socials#getSocials"
    post    "user/social_media/create"      , to: "socials#create"
    put     "user/social_media/update/:id"  , to: "socials#update"
    delete  "user/social_media/delete_all"  , to: "socials#delete_all"
    delete  "user/social_media/delete/:id"  , to: "socials#delete"


    # national event
    get     "national_event"                , to: "national_event#index"
    get     "national_event/mySaved"        , to: "national_event#userIndex"
    get     "national_event/time_between"   , to: "national_event#eventsInMonth"
    post    "national_event/create"         , to: "national_event#create"
    put     "national_event/update/:id"     , to: "national_event#update"
    delete  "national_event/delete/:id"     , to: "national_event#delete"

    # user types and colors
    post    "user/type/create"              , to: "type_for_user#create"
    put     "user/type/:id"                 , to: "type_for_user#update"


  end

end
