@todo
#PivotalTracker ID: 152662847
Feature: Tally Items By Issue
  As a case worker,
  So that I can quickly complete tax forms,
  I want to be able to count the number of each issue and the total cases worked
  
  Background: Items have been added to the database
    
    Given the following items exist:
      | client_ssn | client_name | B_1 | B_5 | B_22 | K_2A | K_2C | K_total |
      | 111111111  | John        | 0   | 0   | 0    | 1     | 1     | 2       |
      | 222222222  | Mary        | 1   | 0   | 0    | 0     | 0     | 0       |
      | 333333333  | young Money | 0   | 1   | 1    | 0     | 1     | 1       |
      | 444444444  | mike        | 1   | 0   | 1    | 1     | 0     | 1       |
    
    Scenario: Count the total of each Form B issue on metrics page
      Given I am on the metrics page
      And   I should see "2 ----- 1. Wages"             
      And   I should see "0 ----- 2. Interest / Dividends (Schedule B)"
      And   I should see "1 ----- 5. IRA / Pension"
      And   I should see "2 ----- 22. Other Interest Expenses"
      And   I should see "5 ----- Total Case Issues Worked (add lines 1 through 62)"

    Scenario: Count the total of each Form K issue on metrics page
      Given I am on the metrics page
      And   I should see "2 ----- 2A. Return Processing"             
      And   I should see "2 ----- 2C. Injured Spouse"
      And   I should see "4 ----- TOTAL (add items 2A through 2AA) (Must equal value in line 1C)"
