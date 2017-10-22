When("I fill in {string} with {string}") do |string, string2|
  fill_in string, :with => string2
end

When("I press {string}") do |string|
  click_button string
end

Then("I should see {string} message") do |string|
  expect(page).to have_content(string)
end

Then("Wait for ajax") do
  Timeout.timeout(Capybara.default_max_wait_time) do
    page.evaluate_script('jQuery.active').zero?
  end
end