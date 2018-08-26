class Type < ApplicationRecord

  # =================== validations
  validates_presence_of :title , :color

  # =================== enum
  enum color: [ :red , :orange , :yellow , :cyan , :azure , :blue , :green , :violet , :magenta , :rose  ]

  # =================== relations

  # =================== many to many

  # user and type
  has_many :users , :through => "user_types" , :foreign_key => "user_id"
  has_many :user_types

  # group and type
  has_many :groups , :through => "group_types" , :foreign_key => "group_id"
  has_many :group_types

  # share event and type
  has_many :share_events , :through => "share_event_types" , :foreign_key => "share_event_id"
  has_many :share_event_types

  # event and type
  has_many :events , :through => "event_types" , :foreign_key => "event_id"
  has_many :event_types

end
