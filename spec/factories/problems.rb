FactoryGirl.define do
  factory :problem do
    text { Faker::StarWars.quote }
    setup { Faker::StarWars.quote }
    function_name { Faker::StarWars.planet }
    association :user, factory: :user
    association :language, factory: :language
  end
end