class Party < ApplicationRecord

  # =========================== validations
  validates_presence_of :theme

  # =========================== relations
  has_many :invites , :dependent => :destroy
  belongs_to :event , :dependent => :destroy


end
