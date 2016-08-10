# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = (1..6).map{|i| FactoryGirl.create(:user, name: "user#{i}") }
users.each.with_index(1) do |user, i|
  (1..25).each do |n|
    attrs = {
      title: "Example title #{i}/#{n}",
      content: "Example content #{i}/#{n}",
      user: user,
      rating: 1 + i + rand(3),
      category: i == 1 ? 'First' : 'Example'
    }
    FactoryGirl.create(:post, attrs)
  end
end
