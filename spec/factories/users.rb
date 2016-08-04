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

FactoryGirl.define do
  factory :user do
    name "User1"
    password_digest { BCrypt::Password.create('password') }
    token { SecureRandom.base58(24) }
    description "User description"
  end
end
