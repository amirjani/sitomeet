class Group < ApplicationRecord
  mount_base64_uploader :photo , GroupUploader
  has_and_belongs_to_many :users

  validates :name , presence: true
  validates :description , presence: true

  after_destroy :delete_members

  def delete_members
    self.group_members.destroy_all
  end

end
