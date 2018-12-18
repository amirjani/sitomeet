class Invite < ApplicationRecord

  #======================= validation
  validates_presence_of :number_of_along

  # ======================= relations
  # ======================= many to many
  has_many :user , :dependent => :destroy

  belongs_to :party
  belongs_to :meeting


end
