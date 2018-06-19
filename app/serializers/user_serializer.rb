class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :city, :email
  has_many :images, include: [:id, :name]
end
