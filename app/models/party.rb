class Party < ApplicationRecord

  # =========================== validations
  validates :theme , presence: true
  validates :is_invite , presence: true
  validates :number_of_along, presence: false
  # validates_presence_of :theme , :is_invite 
  validates_associated :event

  enum is_invite: [:false , :true] 
  
  # =========================== relations
  # has_many :invites , :dependent => :destroy
  belongs_to :event , :dependent => :destroy

  has_many :user , :through => "party_user" , :foreign_key => "user_id"
  has_many :party_user

end
