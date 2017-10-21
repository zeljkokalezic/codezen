Given("{int} Coding problems exist") do |int|
  FactoryGirl.create_list(:problem, int)
end

When("I send a POST request to {string} with valid coding problem data") do |string|
  user = FactoryGirl.create(:user)
  language = FactoryGirl.create(:language)
  params = FactoryGirl.attributes_for(:problem)
               .merge({
                        :user_id => user.id,
                        :language_id => language.id
                      })
  post string, params.to_json
end

Given("Coding problem with text {string} exists") do |string|
  FactoryGirl.create(:problem, {:text => string})
end