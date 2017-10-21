Feature: Home page

  Scenario: Viewing application's home page
    Given I am a new, authenticated user
    When I am on the homepage
    Then I should see "Welcome" message


  Scenario: Viewing application's home page
    Given I am not authenticated
    When I am on the homepage
    Then I should see "Log in" message