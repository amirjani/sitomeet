class NationalEventSerializer < ActiveModel::Serializer
  attributes :id , :date , :is_day_off , :title , :description
end
