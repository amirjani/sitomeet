class EventSerializer < ActiveModel::Serializer
  attributes :id , :user_id , :event_type , :date , :title , :description , :location_lat , :location_long , :address , :start_time , :end_time , :repeat_time , :notification_time , :end_of_repeat , :is_private , :is_verified , :photo
  # belongs_to :user_color_event
end
