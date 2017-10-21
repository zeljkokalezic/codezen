Feature: Coding problem API
  I want to be able to perform CRUD operations
  Trough RESTful API on a coding problem resource

  Scenario: List coding problems authorized
    Given I am a valid API user
    And I send and accept JSON
    And 10 Coding problems exist
    When I send a GET request to "/v1/problems"
    Then the response status should be "200"
    #Then show me the unparsed response
    And the JSON response should have "$..id" with a length of 10

  Scenario: List coding problems unauthorized
    Given I am not authenticated
    When I send a GET request to "/v1/problems"
    Then the response status should be "401"

  Scenario: Create coding problem using valid data
    Given I am a valid API user
    And I send and accept JSON
    When I send a POST request to "/v1/problems" with valid coding problem data
    Then the response status should be "201"
    And the JSON response should have "$..id" with a length of 1
    And the JSON response should have "$..language_id" with the text "1"

  Scenario: Create coding problem using valid data unauthorized
    Given I am not authenticated
    When I send a POST request to "/v1/problems" with valid coding problem data
    Then the response status should be "401"

  Scenario: Create coding problem with invalid parameters
    Given I am a valid API user
    And I send and accept JSON
    When I send a POST request to "/v1/problems"
    Then the response status should be "422"

  Scenario: Update coding problem using valid data
    Given I am a valid API user
    And I send and accept JSON
    And Coding problem with text "Hello world!" exists
    When I send a PATCH request to "/v1/problems/1" with the following:
    """
      {"text":"Updated"}
    """
    Then the response status should be "200"
    And the JSON response should have "$..id" with a length of 1
    And the JSON response should have "$..text" with the text "Updated"

  Scenario: Update coding problem using valid data unauthorized
    Given I am not authenticated
    When I send a PATCH request to "/v1/problems/1"
    Then the response status should be "401"

  Scenario: Update coding problem with invalid parameters
    Given I am a valid API user
    And I send and accept JSON
    And Coding problem with text "Hello world!" exists
    When I send a PATCH request to "/v1/problems/1" with the following:
    """
      {"user_id":"-1"}
    """
    Then the response status should be "422"

  Scenario: Delete coding problem
    Given I am a valid API user
    And I send and accept JSON
    And Coding problem with text "Hello world!" exists
    When I send a DELETE request to "/v1/problems/1"
    Then the response status should be "204"

  Scenario: Delete coding problem unauthorized
    Given I am not authenticated
    When I send a POST request to "/v1/problems" with valid coding problem data
    Then the response status should be "401"

  Scenario: Delete coding problem with invalid problem id
    Given I am a valid API user
    And I send and accept JSON
    When I send a DELETE request to "/v1/problems/1"
    Then the response status should be "404"