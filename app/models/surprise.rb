class Surprise < ApplicationRecord
  # validation
  validates_presence_of :fake_title , :fake_description , :theme , :user_to_surprise_id , :is_invite
  # =================== relations
  enum is_invite: [:true , :false]
  # ============ one to many

  # event and surprise
  belongs_to :event

  # ============ many to many
  has_many :user , :through => "surprise_user" , :foreign_key => "user_id"
  has_many :surprise_user

end
