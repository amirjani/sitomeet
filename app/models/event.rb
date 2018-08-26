class Event < ApplicationRecord
  # =========================== validations
  validates_associated :type
  validates_presence_of :title , :start_time , :end_time

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
  has_many :users , :through => "event_users" , :foreign_key => "user_id"
  has_many :event_users

  # event and types
  has_many :types , :through => "event_types" , :foreign_key => "type_id"
  has_many :event_types

end
