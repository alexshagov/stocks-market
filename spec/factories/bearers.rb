FactoryBot.define do
  factory :bearer do
    name { Faker::Name.name }
    reference { Faker::Internet.uuid }
  end
end
