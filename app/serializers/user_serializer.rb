class UserSerializer < ActiveModel::Serializer
  attributes :id, :name , :phone_number , :sex , :birthday , :role , :photo , :bio , :username , :email , :location , :is_private , :verified
end
