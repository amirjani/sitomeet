class OurLaw < ApplicationRecord

  # validations
  validates_presence_of :title , :description
  #relations
  belongs_to :user , :dependent => :destroy
end
