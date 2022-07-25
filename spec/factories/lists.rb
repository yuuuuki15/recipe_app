FactoryBot.define do
  factory :list do
    ingredient_name { Faker::Food.ingredient }
    ingredient_quantity { Faker::Number.number(2) }
    association :user
  end
end
