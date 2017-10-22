Given("C Language exists") do
  FactoryGirl.create(:language, {:descriptor => "C"})
end


When("I am on the problem list page") do
  visit "/problems"
end

Then("Verify that {int} items are displayed") do |int|
  expect(page).to have_selector('input[name=query]', visible: true)
  expect(page).to have_selector('table', visible: true)
  expect(page).to have_selector('tbody>tr', visible: true, count: int)
end

Then("Test") do
  expect(page).to have_selector('input[name=query]', visible: true)
  expect(page).to have_selector('table', visible: true)
  expect(page).to have_selector('tbody>tr', visible: true, count: 10)
end

Then("Create new coding problem with {string}, {string} and {string}") do |text, function_name, setup|
  click_on('New')
  expect(page).to have_selector('.modal-container', visible: true)
  select("C", from: "languages").select_option
  fill_in 'text', with: text
  fill_in 'function_name', with: function_name
  fill_in 'setup', with: setup
  click_on('Save')
end

Then("Edit that coding problem with {string}, {string} and {string}") do |text, function_name, setup|
  click_on('Edit')
  expect(page).to have_selector('.modal-container', visible: true)
  fill_in 'text', with: text
  fill_in 'function_name', with: function_name
  fill_in 'setup', with: setup
  click_on('Save')
end

Then("Verify that coding problem with {string}, {string} and {string} is displayed") do |text, function_name, setup|
  expect(page).to have_selector('table', visible: true)
  expect(page).to have_selector('tr', visible: true)
  expect(page).to have_selector('td', visible: true, text: text)
  expect(page).to have_selector('td', visible: true, text: setup)
  expect(page).to have_selector('td', visible: true, text: function_name)
end

Then("Verify that validation message is diplayed") do
  expect(page).to have_selector('label', visible: true, text: "Errors:")
end

Then("Display delete dialog") do
  click_on('Delete')
  expect(page).to have_selector('.modal-container', visible: true)
end

Then("Click {string}") do |button_name|
  click_on(button_name)
end

Then("Verify that we are on {string} page") do |path|
  current_path.should == path
end