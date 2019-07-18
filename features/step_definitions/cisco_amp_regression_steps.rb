When(/^I go to the homepage$/) do
  visit root_path
end

Then(/^I click on Signup page$/) do
  click_link 'Sign Up'
end

Then(/^I click on Log In page$/) do
  click_link 'Log In'
end

Then(/^I fill the signup form$/) do
  within("#new_user") do
    fill_in 'user_name', with: 'Test'
    fill_in 'user_email', with: 'test@test.com'
    fill_in 'user_password', with: 'test123'
    fill_in 'user_password_confirmation', with: 'test123'
  end
end

Then(/^I fill the login form$/) do
	user = FactoryBot.create(:user)
	user.confirm
  within("#new_user") do
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: 'test123'
  end
end

Then(/^I click on login button$/) do
  click_button 'Log in'
end

Then(/^I click on signup button$/) do
  click_button 'Sign up'
end

Then(/^I see welcome message$/) do
  expect(page).to have_content 'Signed in successfully'
end
Then(/^I see a confirmation message$/) do
  expect(page).to have_content 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.'
end

Then(/^Upon Confirming i should see account confirmed message$/) do
	user = User.find_by(email: "test@test.com")
  expect(user).not_to be_nil
  expect(user.confirmation_token).not_to be_nil
  ctoken = last_email.body.match(/confirmation_token=\w*/)
  visit "/users/confirmation?#{ctoken}"
  expect(page).to have_content('Your email address has been successfully confirmed.')
end

def last_email
  ActionMailer::Base.deliveries.last
end



