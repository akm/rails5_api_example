class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :created_at
  has_many :posts
end
