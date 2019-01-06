class SocialEventCategory < ApplicationRecord

  validates :title , presence: true

  # ============== one to many
  has_many :social_event_type , :dependent => :destroy

end
