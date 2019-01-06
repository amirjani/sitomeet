class GroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :is_private, :link, :photo, :admins
end
