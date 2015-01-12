Feature: register

  @javascript
  Scenario: when I sign up with email and password
    Given I'm in "the homepage"
    When I click "the login link"
    And I click "the signup link"
    And I fill "user_email" with "teste@teste.com"
    And I fill "user_password" with "mypass"
    And I fill "user_password_confirmation" with "mypass"
    And I press "the submit signup button"
    Then I should be logged in
    And I should be in "the homepage"

  @javascript
  Scenario: when I sign up via Facebook
    Given I'm in "the homepage"
    When I click "the login link"
    When I press "the Facebook login button"
    Then I should be logged in
    And I should be in "the homepage"

  @javascript
  Scenario: when I sign up via Google
    Given I'm in "the homepage"
    When I click "the login link"
    When I press "the Google login button"
    Then I should be logged in
    And I should be in "the homepage"
