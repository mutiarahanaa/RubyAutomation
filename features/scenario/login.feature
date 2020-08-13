Feature: Login FB

@test
Scenario: Login FB
Given I navigate to facebook page
When I verify user is in login page
And I fill username with "adam_vqaiewa_levine@tfbnw.net" and password with "tiaraqa"
And I click login