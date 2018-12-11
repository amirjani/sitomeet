class SocialEventType < ApplicationRecord

  validates :title , presence: true

  # ============== one to many
  belongs_to :social_event_categories  ,     :dependent => :destroy

end
