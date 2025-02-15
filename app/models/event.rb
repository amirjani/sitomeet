class Event < ApplicationRecord
  
  mount_base64_uploader :photo , PersonalEventUploaderUploader
  # =========================== validations
  validates_presence_of :event_type , :title , :date , :location_lat , :location_long , :address , :repeat_time , :notification_time , :end_of_repeat ,  :start_time , :end_time , :is_private , :is_private , :is_verified  

  # =========================== enums
  enum event_type: [ :personal , :surprise , :party , :meeting , :social]

  # enum color: [ :red , :blue , :purple , :cyan , :orange ]

  enum repeat_time: [ :no_repeat , :every_day , :every_week , :every_month , :every_three_month , :every_six_month , :every_year ]

  enum notification_time: [ :no_notification , :five_min_before , :fifteen_min_before , :thirty_min_before , :one_hour_before , :two_hour_before , :one_day_before , :three_day_before]

  # =========================== relations
  # ============== one to one
  has_one :party, :dependent => :destroy
  has_one :surprise, :dependent => :destroy
  has_one :meeting , :dependent => :destroy
  has_one :user_color_event
  # ============== one to many
  belongs_to :user , :dependent => :destroy
  has_many :share_events                , :dependent => :destroy
  # ============== many to many
  # event and groups
  has_many :groups , :through => "event_groups" , :foreign_key => "group_id"
  has_many :event_group
  # event and types
  has_many :types , :through => "event_types" , :foreign_key => "type_id"
  has_many :event_types
  # event and share event
  has_many :share_events , :through => "event_share_events" , :foreign_key => "share_event_id"
  has_many :event_share_events

end
