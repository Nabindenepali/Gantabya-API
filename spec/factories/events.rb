FactoryBot.define do
  factory :event do
    name { Faker::Name.name }
    description { Faker::Lorem.sentence }
    organizer { Faker::Company.name }
    date { Faker::Date.backward(15) }
    image_link { Faker::Internet.url }
    user_id 1
  end
end
