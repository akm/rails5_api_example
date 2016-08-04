class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :category, :rating
  has_one :user
end
