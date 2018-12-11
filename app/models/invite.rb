class Invite < ApplicationRecord

  #======================= validation
  validates_presence_of :number_of_along

  # ======================= relations
  # ======================= many to many
  has_many :users, :dependent => :destroy

  belongs_to :party


end
