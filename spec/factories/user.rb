FactoryBot.define do
  factory :user do
    username { Faker::Fantasy::Tolkien.unique.character }
  end
end