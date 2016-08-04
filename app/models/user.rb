# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)      not null
#  password_digest :string(255)
#  token           :string(255)
#  description     :text(65535)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_token  (token) UNIQUE
#

class User < ApplicationRecord
  has_secure_token
  has_secure_password

  has_many :posts, dependent: :destroy
end
