FactoryBot.define do
  factory :comment do
    content { Faker::Food.description }
    association :user
    association :recipe
  end
end
