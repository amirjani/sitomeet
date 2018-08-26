class NationalEvent < ApplicationRecord

  # validations
  validates_presence_of :date , :title

  # relations
  # one to many
  belongs_to :user , :dependent => :destroy
end
