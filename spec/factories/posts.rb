FactoryGirl.define do
  factory :post do
    association :user, factory: :user
    title "Example title #1"
    content "Example context"
    category "Example"
    rating 1
  end
end
