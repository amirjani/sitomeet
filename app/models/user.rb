class User < ApplicationRecord
  # ======================== password
  has_secure_password
  # ======================== model has an image and uploader
  mount_base64_uploader :photo , UserImageUploader

  # ======================== User::Roles
  # The available roles
  enum role: [ :admin , :normal , :deleted]

  def is?( requested_role )
    self.role == requested_role.to_s
  end

  # ====================== validation
  validates :first_name , presence: true
  validates :family_name , presence: true
  validates :phone_number ,  presence: true, uniqueness: true
  # validates :password , presence: true
  validates :sex , presence: true
  validates :birthday , presence: true
  validates :email , presence: true
  validates :password_digest , confirmation: true
  validates :photo , file_size: { less_than: 5.megabytes }

  #validates_presence_of :event
  #validates_presence_of :party
  # ======================= enum
  enum sex: [ :male , :female ]

  # ======================= relations
 # =========================== one to one 
  has_many :user_color_event , :dependent => :destroy 
  #has_many :event_color , :dependent => :destroy
  # ============== one to many
  has_many :national_event , :dependent => :destroy
  has_many :our_laws , :dependent => :destroy
  has_many :socials , :dependent => :destroy
  has_many :off_days , :dependent => :destroy
  has_many :social_event , :dependent => :destroy
  has_and_belongs_to_many :groups
  has_many :event , :dependent => :destroy

  # ============== many to many
  has_many :party , :through => "party_user" , :foreign_key => "party_id"
  has_many :party_user

  has_many :meeting , :through => "meeting_user" , :foreign_key => "meeting_id"
  has_many :meeting_user

  # surprise and user
  has_many :surprise , :through => "surprise_user" , :foreign_key => "surprise_id"
  has_many :surprise_user


end
