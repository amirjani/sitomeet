class SocialEvent < ApplicationRecord
  mount_base64_uploader :photo , SocialEventPhotoUploader

  validates_presence_of :title , :description , :price , :is_available , :capacity , :social_event_category_id , :social_event_type_id

  has_one :social_event_category 
  has_one :social_event_type 
  belongs_to :user

end
