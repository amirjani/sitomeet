class User < ApplicationRecord
  # ======================== password
  has_secure_password

  # ======================== User::Roles
  # The available roles
  enum role: [ :admin , :normal , :deleted]

  def is?( requested_role )
    self.role == requested_role.to_s
  end

  # ====================== validatioon
  validates :password_digest , confirmation: true
  validates :phone_number , uniqueness: true

  # ======================= enum
  enum sex: [ :male , :female ]

  # ======================= relations

  # ============== one to many
  has_many :national_event , :dependent => :destroy
  has_many :socials

  # ============== many to many

  # user and types
  has_many :types , :through => "user_types" , :foreign_key => "type_id"
  has_many :user_types

  # user and events
  has_many :events , :through => "event_users" , :foreign_key => "event_id"
  has_many :event_users

  # surprise and user
  has_many :surprises , :through => "surprise_users" , :foreign_key => "surprise_id"
  has_many :surprise_users

  # group and user
  has_many :groups , :through => "group_users" , :foreign_key => "group_id"
  has_many :group_types

end