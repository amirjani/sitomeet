class EventShareEvent < ApplicationRecord

  belongs_to :event
  belongs_to :share_event

end
