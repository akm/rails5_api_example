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

  class << self
    def current_user=(user)
      Thread.current[:current_user] = user
    end

    def current_user
      Thread.current[:current_user]
    end

    def current(user)
      orig_user, User.current_user = User.current_user, user
      begin
        return yield
      ensure
        User.current_user = orig_user
      end
    end
  end

end
