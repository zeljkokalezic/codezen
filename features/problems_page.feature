Feature: Problems page
  I want to be able to perform CRUD operations
  Trough GUI via AJAX on a coding problem resource

  Scenario: Viewing problem list
    Given I am not authenticated
    When I am on the problem list page
    Then I should see "Log in" message

  @javascript
  Scenario: Viewing problem list
    Given I am a new, authenticated user
    And 10 Coding problems exist
    When I am on the problem list page
    Then Wait for ajax
    Then Verify that 10 items are displayed

  @javascript
  Scenario Outline: Creating a coding problem
    Given I am a new, authenticated user
    And 0 Coding problems exist
    And C Language exists
    When I am on the problem list page
    Then Wait for ajax
    Then Create new coding problem with "<text>", "<function_name>" and "<setup>"
    Then Wait for ajax
    Then Verify that coding problem with "<text>", "<function_name>" and "<setup>" is displayed

  Examples:
    | text               | function_name | setup              |
    | Write hello world. | hello_world   | hello_world()      |
    | Write fibonacci.   | fibonacci     | fibonacci(int n)   |

  @javascript
  Scenario Outline: Creating a coding problem with invalid data
    Given I am a new, authenticated user
    And 0 Coding problems exist
    And C Language exists
    When I am on the problem list page
    Then Create new coding problem with "<text>", "<function_name>" and "<setup>"
    Then Wait for ajax
    Then Verify that validation message is diplayed

    Examples:
      | text               | function_name | setup              |
      | Write hello world. |               | hello_world()      |
      | Write fibonacci.   | fibonacci     |                    |
      |                    | fibonacci     |                    |
      |                    |               |                    |

  @javascript
  Scenario Outline: Editing a coding problem
    Given I am a new, authenticated user
    And 0 Coding problems exist
    And C Language exists
    When I am on the problem list page
    Then Wait for ajax
    Then Create new coding problem with "<text>", "<function_name>" and "<setup>"
    Then Wait for ajax
    Then Verify that coding problem with "<text>", "<function_name>" and "<setup>" is displayed
    Then Wait for ajax
    Then Edit that coding problem with "<edit_text>", "<edit_function_name>" and "<edit_setup>"
    Then Wait for ajax
    Then Verify that coding problem with "<edit_text>", "<edit_function_name>" and "<edit_setup>" is displayed

    Examples:
      | text               | function_name | setup              | edit_text          | edit_function_name | edit_setup              |
      | Write hello world. | hello_world   | hello_world()      | Write world.       | world              | int hello_world()       |
      | Write fibonacci.   | fibonacci     | fibonacci(int n)   | Write function.    | function           | long fibonacci(int n)   |

  @javascript
  Scenario: Deleting problem
    Given I am a new, authenticated user
    And 1 Coding problems exist
    When I am on the problem list page
    Then Wait for ajax
    Then Verify that 1 items are displayed
    Then Display delete dialog
    Then Click "OK"
    Then Verify that 0 items are displayed

  @javascript
  Scenario: Cancel deleting problem
    Given I am a new, authenticated user
    And 1 Coding problems exist
    When I am on the problem list page
    Then Wait for ajax
    Then Verify that 1 items are displayed
    Then Display delete dialog
    Then Click "Cancel"
    Then Verify that 1 items are displayed

  @javascript
  Scenario: View problem details
    Given I am a new, authenticated user
    And 1 Coding problems exist
    When I am on the problem list page
    Then Wait for ajax
    Then Verify that 1 items are displayed
    Then Click "View"
    Then Verify that we are on "/problems/1" page
    Then I should see "Problem Details for:" message