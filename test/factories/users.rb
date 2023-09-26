FactoryBot.define do
  factory :user do
    name { "James Allen" }
    email { "james@example.com" }
    password { "password" }
  end

  factory :random_user, class: User do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { "password" }
  end
end
