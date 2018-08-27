class OffDay < ApplicationRecord
  # ===================== validation
  validates_presence_of :date

  # ===================== relationship
  # ============ one to many
  # user and off day
  belongs_to :user

end
