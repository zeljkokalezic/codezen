include Warden::Test::Helpers

Given("I am a new, authenticated user") do
  user = FactoryGirl.create(:user)
  visit '/users/sign_in'
  fill_in "user_email", :with => user.email
  fill_in "user_password", :with => "HAXXOR123"
  click_button "Log in"
end

Given("I am not authenticated") do
  logout
  visit('/users/sign_out')
end

When("I go to register") do
  visit new_user_registration_path
end

Given /^I am a valid API user$/ do
  user = FactoryGirl.create(:user)

  #not working without login_as, not much time for investigation
  token = Knock::AuthToken.new(payload: { sub: user.id }).token
  header 'Authorization', "Bearer #{token}"

  login_as(user, scope: :user)
end