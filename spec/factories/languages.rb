FactoryGirl.define do
  factory :language do
    descriptor { 'C' }
    service_url { Faker::Internet.url }
    auth_token { Faker::Internet.password }
  end
end