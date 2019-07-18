Feature: CISCO Regression
  As a product manager
  I want our users to login and access the Computer information

  Scenario: User Signup for an account
    When I go to the homepage
    Then I click on Signup page
    Then I fill the signup form
    Then I click on signup button
    Then I see a confirmation message
    Then Upon Confirming i should see account confirmed message

  Scenario: User Sign Into his confirmed Account
    When I go to the homepage
    Then I click on Log In page
    Then I fill the login form
    Then I click on login button
    Then I see welcome message