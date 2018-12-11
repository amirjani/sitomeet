class SocialEvent < ApplicationRecord

  validates_presence_of :title , :description , :price , :is_available , :capacity

  has_one :social_event_category , dependent: :destroy
  has_one :social_event_type , dependent: :destroy

end
