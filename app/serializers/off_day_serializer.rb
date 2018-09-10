class OffDaySerializer < ActiveModel::Serializer
  attributes :id , :user_id , :date , :description
end
