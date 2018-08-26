class Group < ApplicationRecord

  #======================= validation
  validates_presence_of :title
  validates_associated :users , :types , :events

  # ======================= enum
  enum status [ :undefined , :accepted , :rejected ]

  # ======================= relations
  # ======================= many to many

  # event and group
  has_many :events , :through => "event_groups" , :foreign_key => "event_id"
  has_many :event_groups

  # group and type
  has_many :types , :through => "group_types" , :foreign_key => "type_id"
  has_many :group_types

  # group and user
  has_many :users , :through => "group_users" , :foreign_key => "user_id"
  has_many :group_users

end
