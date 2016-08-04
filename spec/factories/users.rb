FactoryGirl.define do
  factory :user do
    name "User1"
    password_digest { BCrypt::Password.create('password') }
    token { SecureRandom.base58(24) }
    description "User description"
  end
end
