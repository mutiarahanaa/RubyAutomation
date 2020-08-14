Feature: Login FB

@test
Scenario: Login FB
Given I navigate to "ENV:BASEURL" page
When I verify user is in login page
And I login using username "ENV:USERNAME" and password "ENV:PASSWORD"
And verify success login