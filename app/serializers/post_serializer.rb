# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  title      :string(255)      not null
#  content    :text(65535)
#  category   :string(255)
#  rating     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#

class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :category, :rating, :created_at, :updated_at,
             :username, :editable?
  has_one :user

  def username
    object.user.name
  end

  def editable?
    User.current_user.try(:id) == object.user_id
  end
end
