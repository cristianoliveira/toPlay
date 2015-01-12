Given(/^(?:I'm in|I go to) "(.*?)"$/) do |arg1|
  visit to_url(arg1)
end

Given(/^there is an user$/) do
  @user = User.make!
end

Given(/^there is a "([^"]*)" user$/) do |provider|
  @user = User.make! email: 'josias.ds@gmail.com'
  Identity.make! user: @user, provider: provider
end

When /^I press "([^"]*)"$/ do |arg1|
  click_button to_button(arg1)
end

When /^I click "([^"]*)"$/ do |arg1|
  click_link to_link(arg1)
end

When(/^I fill "([^"]*)" with "([^"]*)"$/) do |field, text|
  fill_in field, with: to_text(text)
end

Then(/^I should be in "(.*?)"$/) do |arg1|
  expect(page.current_path).to eq to_url(arg1)
end

Then(/^I should be logged in$/) do
  expect(page).to have_css(".login", text: @user.email)
end

Then(/^I should see "(.*?)"$/) do |arg1|
  expect(page).to have_css(to_element(arg1), text: to_text(arg1))
end

Then(/^I should not see "(.*?)"$/) do |arg1|
  expect(page).to_not have_css(to_element(arg1), text: to_text(arg1))
end
