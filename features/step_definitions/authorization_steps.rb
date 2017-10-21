Given("I am a new, authenticated user") do
  user = FactoryGirl.create(:user)
  visit '/users/sign_in'
  fill_in "user_email", :with => user.email
  fill_in "user_password", :with => user.email
  click_button "Log in"
end

Given("I am not authenticated") do
  #visit('/users/sign_out')
end

When("I go to register") do
  visit new_user_registration_path
end