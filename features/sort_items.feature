Feature: Sort Items
  As a case worker
  So that I can find the item I'm looking for
  I want to be able to sort items by SSN or Name

  Background: items have been added to database

    Given the following items exist:
      | client_ssn | client_name  | date_opened | date_closed |
      | 111111111  | John Doe     | 25-Nov-9999 | 15-Dec-9999 |
      | 222222222  | Sally Sue    | 30-Nov-9999 | 13-Dec-9999 |
      | 333333333  | Billy Bob    | 11-Nov-9999 | 21-Dec-9999 |
      | 000000000  | Ender Wiggin | 10-Nov-9999 | 11-Dec-9999 |

  Scenario: Sort by Date Opened
    Given I am on the items index page
    When I follow "date_opened_header"
    Then I should see "222222222" before "111111111"
    And I should see "111111111" before "333333333"
    And I should see "333333333" before "000000000"

  Scenario: Sort by Date Closed
    Given I am on the items index page
    When I follow "date_closed_header"
    Then I should see "333333333" before "111111111"
    And I should see "111111111" before "222222222"
    And I should see "222222222" before "000000000"

  Scenario: Sort by Name
    Given I am on the items index page
    When I follow "client_name_header"
    Then I should see "Billy Bob" before "John Doe"
    And I should see "John Doe" before "Sally Sue"
    And I should not see "Sally Sue" before "Billy Bob"

