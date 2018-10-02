class User < ApplicationRecord
  # ======================== password
  has_secure_password
  # ======================== model has an image and uploader
  mount_uploader :photo , UserImageUploader

  # ======================== User::Roles
  # The available roles
  enum role: [ :admin , :normal , :deleted]

  def is?( requested_role )
    self.role == requested_role.to_s
  end

  # ====================== validation
  validates :password_digest , confirmation: true
  validates :phone_number , uniqueness: true
  validates :photo , file_size: { less_than: 5.megabytes }

  # ======================= enum
  enum sex: [ :male , :female ]

  # ======================= relations

  # ============== one to many
  has_many :national_event  ,     :dependent => :destroy
  has_many :socials         ,     :dependent => :destroy
  has_many :off_days        ,     :dependent => :destroy

  # ============== many to many

  # user and types
  has_many :types , :through => "user_types" , :foreign_key => "type_id"
  has_many :user_types

  # user and events
  has_many :event , :through => "event_users" , :foreign_key => "events_id"
  has_many :event_users

  # surprise and user
  has_many :surprises , :through => "surprise_users" , :foreign_key => "surprise_id"
  has_many :surprise_users

  # group and user
  has_many :groups , :through => "group_users" , :foreign_key => "group_id"
  has_many :group_types

end