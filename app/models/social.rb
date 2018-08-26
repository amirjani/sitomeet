class Social < ApplicationRecord

  # validations
  validates_presence_of :name , :link

  # enum
  enum name: [ :twitter , :facebook , :telegram , :instagram , :snapchat , :soroush ]

  # relations
  # one to many
  belongs_to :user
end
