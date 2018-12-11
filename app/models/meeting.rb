class Meeting < ApplicationRecord

  validates_presence_of :priority

  enum priority: [ :instant , :important , :normal ]

  has_many :invites , :dependent => :destroy
  belongs_to :event

end
