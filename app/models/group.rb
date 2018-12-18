class Group < ApplicationRecord
  has_many :group_photos
  has_many :group_members
  has_one :owner, :class_name => "User", :foreign_key => "owner"

  validates :name , presence: true
  validates :description , presence: true
  validates :link , presence: true

end
