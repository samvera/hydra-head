@catalog @articles
Feature: Article Search Result
  As a user
  In order to find articles
  I want to see appropriate information about articles in a search result

  Scenario: Viewing search results
    Given I am on the home page
    And I fill in "q" with "1234-5678"
    When I press "submit"
    Then I should see a link to "the show document page for hydrangea:fixture_mods_article3"
    And I should see "Test Article"
    And I should see "Aug. 1, 1998"

  Scenario: html5 valid - unauthenticated 
    Given I am on the home page
    When I follow "Article"
    Then the page should be HTML5 valid

  Scenario: html5 valid - authenticated 
    Given I am logged in as "archivist1" 
    When I am on the home page
    And I follow "Article"
    Then the page should be HTML5 valid

