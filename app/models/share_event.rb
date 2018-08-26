class ShareEvent < ApplicationRecord

  # ==================== validations
  validates_presence_of :start_time , :end_time
  # validates_associated :types

  # ==================== relations

  # ========== one to many
  belongs_to :event

  # ========== many to many

  # share event and type
  has_many :types , :through => "share_event_types" , :foreign_key => "type_id"
  has_many :share_event_types

  # share event and event
  has_many :events , :through => "event_share_events" , :foreign_key => "event_id"
  has_many :event_share_events

end
