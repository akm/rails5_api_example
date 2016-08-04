FactoryGirl.define do
  factory :post do
    user nil
    title "MyString"
    content "MyText"
    category "MyString"
    rating 1
  end
end
