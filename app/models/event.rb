class Event < ApplicationRecord
  # =========================== validations
  validates_presence_of :title , :start_time , :end_time , :is_private

  # =========================== relations
  # ============== one to one
  has_one :surprise                , :dependent => :destroy
  has_one :invite_friend          , :dependent => :destroy
  # ============== one to many
  has_many :share_events                , :dependent => :destroy
  # ============== many to many
  # event and groups
  has_many :groups , :through => "event_groups" , :foreign_key => "group_id"
  has_many :event_groups
  # event and user
  has_many :user , :through => "event_users" , :foreign_key => "users_id"
  has_many :event_users
  # event and types
  has_many :types , :through => "event_types" , :foreign_key => "type_id"
  has_many :event_types
  # event and share event
  has_many :share_events , :through => "event_share_events" , :foreign_key => "share_event_id"
  has_many :event_share_events

end
