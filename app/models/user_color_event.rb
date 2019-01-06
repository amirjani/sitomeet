class UserColorEvent < ApplicationRecord
 
 validates :event_type , presence: true
 validates :event_color , presence: true 
 
 enum event_type: [ :personal , :surprise , :party , :meeting , :social ]
 enum event_color: [ :red , :blue , :purple , :cyan , :orange ]

 belongs_to :user

end
