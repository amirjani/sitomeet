class EventColor < ApplicationRecord

  # ===================== validation
  validates_presence_of :type , :color

  # ===================== enums
  enum type: [ :personal , :surprise , :party , :meeting , :social]
  enum color: [ :red , :blue , :purple , :cyan , :orange ]

  # ===================== relations
  belongs_to :event

end
