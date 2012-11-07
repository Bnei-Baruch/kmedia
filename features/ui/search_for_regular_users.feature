Feature: Search (for regular users)
  As a regular user
  I want to be able to search
  So that I can find catalogs and files

  Scenario Outline: Search for pattern without filters
    Given no filters are selected
    When I go to the show search results page
    And searching for a pattern "<pattern>"
    Then "<found>" result(s) should be found

  Examples:
    | pattern | found |
    | rav     | 2     |
    | norav   | 0     |
    |         | 0     |


  Scenario Outline: Search for pattern with filters
  Examples:
    |  |
