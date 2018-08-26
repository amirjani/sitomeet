class Invited < ApplicationRecord

  validates_presence_of :name

  # relations
  # one to one
  belongs_to :invite_friend
end
