class Meeting < ApplicationRecord

  validates_presence_of :priority , :is_invite

  enum priority: [:instant , :important , :normal ]
  enum is_invite: [:false , :true]

  #has_many :invites , :dependent => :destroy
  belongs_to :event

  has_many :user , :through => "meeting_user" , :foreign_key => "user_id"
  has_many :meeting_user

end
