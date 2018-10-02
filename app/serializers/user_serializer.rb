class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name , :family_name , :phone_number , :sex , :birthday , :role , :photo , :bio , :username , :email , :location , :is_private , :verified
end
