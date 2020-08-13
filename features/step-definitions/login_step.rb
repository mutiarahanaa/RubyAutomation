

Given /^I navigate to facebook page$/ do
    visit "/"
    @login_search = LoginPage.new
  end
  
#   Given /^I search for "(.*?)"$/ do |search_term|
#     @page_search = LoginPage.new
#   end
  
  And /^I verify user is in login page$/ do
    expect(@login_search).to have_username
    expect(@login_search).to have_password
    #@login_search.isFieldLoginPresent
  end

  And /^I fill username with "([^\"]*)" and password with "([^\"]*)"$/ do |username, password|
    @login_search.fillLogin(username,password)
    end

  Then /^I click login$/ do
    puts @login_search.clickLogin
  end