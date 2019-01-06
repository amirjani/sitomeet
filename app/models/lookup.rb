class Lookup < ApplicationRecord
  mount_base64_uploader :icon , LookupUploader
end
