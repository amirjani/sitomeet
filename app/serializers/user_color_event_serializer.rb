class UserColorEventSerializer < ActiveModel::Serializer
  attributes :id , :event_type , :event_color
  belongs_to :user
end
