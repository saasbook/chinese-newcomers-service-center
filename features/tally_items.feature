@todo
#PivotalTracker ID: 152662847
Feature: Tally Items By Issue
  As a case worker
  So that I can quickly complete tax forms
  I want to be able to count and view cases of a certain issue type
  
  Background: Items have been added to the database
    
    Given the following items exist:
      | client_ssn | client_name | B_1 | B_5 | B_22 |
      | 111111111  | John        | 0   | 0   | 0    |
      | 222222222  | Mary        | 1   | 0   | 0    |
      | 333333333  | young Money | 0   | 1   | 1    |
      | 444444444  | mike        | 1   | 0   | 1    |
    
    Scenario: Sort by Income Wages Issue
      Given I am on the items index page
      When I check "B_1"
      And I uncheck "B_5"
      And I uncheck "B_22"
      And I press "Filter"
      Then I should see "Mary"
      And I should see "mike"
      And I should not see "John"
      And I should not see "young Money"
      And I should see "Total Cases: 2"
      
    Scenario: Sort by Income Wages Issue and Income IRA Pension Issue
      Given I am on the items index page
      When I check "B_1"
      And I check "B_5"
      And I uncheck "B_22"
      And I press "Filter"
      Then I should see "Mary"
      And I should see "young Money"
      And I should see "mike"
      And I should not see "John"
      And I should see "Total Cases: 3"
      
    Scenario: Uncheck all relevant issues
      Given I am on the items index page
      When I uncheck "B_5"
      And I uncheck "B_1"
      And I uncheck "B_22"
      And I press "Filter"
      Then I should not see "Mary"
      And I should not see "young Money"
      And I should not see "mike"
      And I should not see "John"
      And I should see "Total Cases: 0"
      