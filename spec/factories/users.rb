FactoryGirl.define do
  factory :user do
    email = Faker::Internet.email
    email { email }
    password { email }
  end
end