#PivotalTracker ID: 151967979
Feature: Upload File
  As a case worker,
  So that I can refer to completed paper tax forms,
  I want to be able to upload and view files for each case.
    
  Background: Items have been added to the database
    
    Given the following items exist:
      | client_ssn | client_name | B_1 | B_5 | B_22 | K_2A | K_2C | K_total |
      | 111111111  | John        | 0   | 0   | 0    | 1    | 1    | 2       |
      | 222222222  | Mary        | 1   | 0   | 0    | 0    | 0    | 0       |
      | 333333333  | young Money | 0   | 1   | 1    | 0    | 1    | 1       |
      | 444444444  | mike        | 1   | 0   | 1    | 1    | 0    | 1       |
    
    Scenario: Attach a document to a new item
      Given I am on the new item page
      And   I fill in "Client SSN" with "666"
      When  I upload "exampleFiles/Lorem-Ipsum.pdf" to "item_document1" do |file, doc|
      And   I press "Create Case"
      And   I go to the show item page for "666"
      Then  I should see "Lorem-Ipsum.pdf"

    Scenario: Delete a document attached to an existing item
      Given I am on the new item page
      And   I fill in "Client SSN" with "666"
      When  I upload "exampleFiles/Lorem-Ipsum.pdf" to "item_document1" do |file, doc|
      And   I press "Create Case"
      And   I go to the show item page for "666"
      Then  I should see "Lorem-Ipsum.pdf"
      And   I go to the edit item page for "666"
      And   I check "remove_document1"
      And   I press "Save Changes"
      Then  I go to the show item page for "666"
      And   I should not see "Lorem-Ipsum.pdf"
      
    Scenario: Upload an invalid document not of specified file type
      Given I am on the new item page
      And   I fill in "Client SSN" with "666"
      When  I upload "exampleFiles/Lorem-Ipsum.abc" to "item_document1" do |file, doc|
      And   I press "Create Case"
      Then  I should see "Error:"
      Then  I should see "Document1 is invalid."