FactoryBot.define do
  factory :stock do
    name { Faker::IDNumber.valid }
    reference { Faker::Internet.uuid }
  end
end
