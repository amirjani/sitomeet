class InviteFriend < ApplicationRecord

  # validations
  validates_presence_of :number , :events_id

  # relations
  # one to one
  belongs_to :event
  # many to one
  has_many :inviteds , :dependent => :destroy
end
