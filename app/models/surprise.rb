class Surprise < ApplicationRecord
  # validation
  validates_presence_of :fake_title , :fake_description , :theme

  # =================== relations

  # ============ one to many

  # event and surprise
  belongs_to :event

  # ============ many to many
  has_many :users , :through => "surprise_users" , :foreign_key => "user_id"
  has_many :surprise_users

end
