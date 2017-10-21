FactoryGirl.define do
  factory :language do
    descriptor { 'C' }
    service_url { Faker::Internet.url }
  end
end