Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :v1 , :defaults => {:format => :json} do    
    # ============== user's registration and login =================== #
    post    "user/register"                 , to: "user#register"
    put     "user/verify"                   , to: "user#verification"
    post    "user/token"                    , to: "authentication#authenticateUser"
    post    "user/resend_code"              , to: "user#resendCode"
    post    "user/reset_password"           , to: "user#resetPassword"
    put     "user/update_password"          , to: "user#updatePassword"
    delete  "user/delete_account"           , to: "user#deleteUser"
    # ============== user's profile ================================= #
    get     "user/profile"                  , to: "user#profile"
    put     "user/update_profile"           , to: "user#updateProfile"
    put     "user/upload_profile_picture"   , to: "user#uploadProfilePicture"
    # ============== social event routes ======================  #    
    # ============== personal evenet routes =================== # 
    post    "personal_event/create"         , to: "event#personalEventCreate"
    get     "personal_event/all"            , to: "event#getAllPersonalEvent"
    get     "personal_event/month"          , to: "event#getMonthPersonalEvent"
    put     "personal_event/update/:id"     , to: "event#eventChange"
    delete  "personal_event/delete/:id"     , to: "event#personalEventDelete"
    get     "personal_event"                , to: "event#getTodayPersonalEvent"
    get     "personal_event/:id"            , to: "event#getOnePersonalEvent"
    # ============== party event routes ============================= # 
    post    "party_event/create"            , to: "party#createParty"
    get     "party_event/all"               , to: "party#getAllPartyEvents"
    get     "party_event"                   , to: "party#getSpecifiedTimePartyEvent"
    put     "party_event/update/:id"        , to: "party#updateParty"
    match   "party_event/delete/:id"        , to: "party#deleteEvent", via: "delete"
    get     "party_event/today"             , to: "party#todayParty"
    get     "party_event/:id"               , to: "party#getOneParty"
    # ============== surprise event ================================= # 
    post    "surprise/create" 		    , to: "surprise#create"
    get     "surprise/all"                  , to: "surprise#getAll"
    get     "surprise/between"              , to: "surprise#betweenTime"
    get     "surprise/today"                , to: "surprise#getToday"
    get     "surprise/show/:id"             , to: "surprise#show"
    delete  "surprise/delete/:id"           , to: "surprise#delete" 
    # ============== meeting event ================================== # 
    post    "meeting_event"                 , to: "meeting#create"
    get     "meeting_event/all"             , to: "meeting#getAll"
    get     "meeting_event/between"         , to: "meeting#betweenTime"
    get     "meeting_event/today"           , to: "meeting#today"
    get     "meeting_event/show/:id"        , to: "meeting#show" 
    delete  "meeting_event/delete/:id"      , to: "meeting#delete" 
    # ============== social media =================================== #
    get     "user/social_media"             , to: "socials#getSocials"
    post    "user/social_media/create"      , to: "socials#create"
    put     "user/social_media/update/:id"  , to: "socials#update"
    delete  "user/social_media/delete_all"  , to: "socials#delete_all"
    delete  "user/social_media/delete/:id"  , to: "socials#delete"
    # =============== user types =================================== #
    get     "user/type"                     , to: "type_for_user#getUserTypes"
    get     "user/type/find"                , to: "type_for_user#find"
    post    "user/type/create"              , to: "type_for_user#create"
    put     "user/type/:id"                 , to: "type_for_user#update"
    delete  "user/type/delete/:id"          , to: "type_for_user#delete"
    # ============== user off days ================================ #
    get     "user/off_day"                  , to: "off_day#offDayUser"
    get     "user/off_day/from_to"          , to: "off_day#offDayFromTo"
    post    "user/off_day/create"           , to: "off_day#create"
    put     "user/off_day/update/:id"       , to: "off_day#update"
    delete  "user/off_day/delete/:id"       , to: "off_day#delete"
    # ============== user event =================================== #
    post    "user/event/create"             , to: "event#create"
    # ============== our law ====================================== #
    get     "our_law"                       , to: "our_law#show"
    # ============== national event routes ======================== #
    get     "today_national_event"          , to: "national_event#todayEvent"
    get     "national_event/time_between"   , to: "national_event#eventsInMonth"
    # ============== national event routes ======================== #
    get     "today_event"                   , to: "event#todayEvent"
    # ============== group routes =================================#
    get "groups", to: "groups#getGroups"
    post "group", to: "groups#createGroup"
    put "group/:id", to: "groups#updateGroup"
    get "group/:id", to: "groups#getGroup"

    # ============== contact ===================== #
    post "contacts", to: "user#insertContactNumbers"
    get "contacts", to: "user#getContacts"
    # ============= lookup ======================= #
    get "lookup", to: "lookup#getLookup"
    get "shake", to: "shake#make"    



    namespace :admin , :defaults => {:format => :json} do
      # ============= user event ======================== #
      get     "users"                             , to: "user#index"
      get     "users/active"                      , to: "user#indexActiveUser"
      get     "users/deleted"                     , to: "user#indexDeletedUser"
      delete  "user/:id/delete"                   , to: "user#delete"
      put     "user/:id/verify"                   , to: "user#verify"

      # ============== national event =================== #
      get     "national_event"                    , to: "national_event#index"
      get     "national_event/mySaved"            , to: "national_event#userIndex"
      get     "national_event/time_between"       , to: "national_event#eventsInMonth"
      post    "national_event/create"             , to: "national_event#create"
      put     "national_event/update/:id"         , to: "national_event#update"
      delete  "national_event/delete/:id"         , to: "national_event#delete"

      # ============== user social index ================= #
      get     "user/:user_id/social"              , to: "social#indexUserSocial"
      get     "user/:user_id/social/:id"          , to: "social#showSocial"
      delete  "user/:user_id/social/:id/delete"   , to: "social#delete"
      put     "user/:user_id/social/:id/update"   , to: "social#update"

      # ============== user social index ================= #
      get     "user/:user_id/off_day"             , to: "off_day#index"
      get     "user/:user_id/off_day/:id"         , to: "off_day#show"
      delete  "user/:user_id/off_day/:id/delete"  , to: "off_day#delete"
      put     "user/:user_id/off_day/:id/update"  , to: "off_day#update"

      # ============== our law ===================== #
      get     "our_law"                           , to: "our_law#show"
      post    "our_law"                           , to: "our_law#store"
      put     "our_law"                           , to: "our_law#update"
      delete  "our_law"                           , to: "our_law#delete"

      # ============== social event category ================ # 
      post     "social_event_category"             , to: "social_event_category#create"
      get      "social_event_category/all"         , to: "social_event_category#getAll"
      put      "social_event_category/:id"         , to: "social_event_category#update"
      delete   "social_event_category/:id"         , to: "social_event_category#delete"

      # ============== social event category type ========================# 
      post     "social_event_type"		          , to: "social_event_type#create"
      get      "social_event_type"                        , to: "social_event_type#categoryType"
      delete   "social_event_type/:social_event_type_id"  , to: "social_event_type#delete"
      put      "social_event_type/:social_event_type_id"  , to: "social_event_type#update"
            
    end
  end

end
