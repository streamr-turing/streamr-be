FactoryBot.define do
  factory :user do
    username { Faker::Fantasy::Tolkien.unique.character }
    avatar_url { Faker::Internet.unique.url }
  end
end