class Party < ApplicationRecord

  # =========================== validations
  validates_presence_of :theme , :is_invite 
  validates_associated :event
  # =========================== relations
  has_many :invites , :dependent => :destroy
  belongs_to :event , :dependent => :destroy

  has_many :user , :through => "party_user" , :foreign_key => "user_id"
  has_many :party_user

end
