FactoryBot.define do
  factory :ingredient do
    name { Faker::Food.ingredient }
    quantity { Faker::Number.number(2) }
    association :recipe
  end
end
