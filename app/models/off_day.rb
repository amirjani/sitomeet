class OffDay < ApplicationRecord
  # ===================== validation
  validates_presence_of :date , :user_id

  # ===================== relationship
  # ============ one to many
  # user and off day
  has_many :users , :dependent => :destroy

end
