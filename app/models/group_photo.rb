class GroupPhoto < ApplicationRecord
  mount_base64_uploader :file , GroupUploader
  belongs_to :group
end
