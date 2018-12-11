class OffDaySerializer < ActiveModel::Serializer
  attributes :id , :user_id , :date , :is_all_day , :start , :end
end
