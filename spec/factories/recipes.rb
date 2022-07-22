FactoryBot.define do
  factory :recipe do
    title { Faker::Food.dish }
    amount { Faker::Number.number }
    tip { Faker::Food.description }
    public_id { 0 }
    association :user

    after(:build) do |recipe|
      recipe.image.attach(io: File.open('public/test_image.png'), filename: 'test_image.png')
    end
  end
end
