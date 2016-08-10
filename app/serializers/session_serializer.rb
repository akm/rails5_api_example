class SessionSerializer < ActiveModel::Serializer
  attributes :id, :name, :token
end
