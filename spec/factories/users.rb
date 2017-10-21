FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { "HAXXOR123" }
  end
end