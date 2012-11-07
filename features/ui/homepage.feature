Feature: Homepage for regular users
  As a regular user
  I want to be able to visit homepage
  So that I can find there the most recent lesson and something else

  Scenario: Last morning lesson was today
    Given regular user visits homepage
    When today was morning lesson
    Then I should see today's lesson
    And I should see something else

  Scenario: Last morning lesson was yesterday
    Given regular user visits homepage
    When today was no morning lesson
    Then I should see yesterday's lesson
    And I should see something else

