Feature: login

  @javascript
  Scenario: when I log in with email and password
    Given I'm in "the homepage"
    And there is an user
    When I click "the login link"
    And I fill "user_email" with "this user's email"
    And I fill "user_password" with "this user's password"
    And I press "the submit login button"
    Then I should be logged in
    And I should be in "the homepage"

  @javascript @omniauth_test
  Scenario: when I log in via Facebook
    Given I'm in "the homepage"
    And there is a "Facebook" user
    When I click "the login link"
    When I press "the Facebook login button"
    Then I should be logged in
    And I should be in "the homepage"

  @javascript @omniauth_test
  Scenario: when I log in via Google
    Given I'm in "the homepage"
    And there is a "Google" user
    When I click "the login link"
    When I press "the Google login button"
    Then I should be logged in
    And I should be in "the homepage"
