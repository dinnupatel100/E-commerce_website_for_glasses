class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :email, :mobile_no, :address, :city, :postal_code
end
