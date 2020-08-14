
Given /^I navigate to "([^\"]*)" page$/ do |url|
    visit ENV['BASEURL']
    @login_search = LoginPage.new
  end
  
  And /^I verify user is in login page$/ do
    expect(@login_search).to have_username
    expect(@login_search).to have_password
  end

  And /^I login using username "([^\"]*)" and password "([^\"]*)"$/ do |username, password|
    @login_search.fillLogin(ENV['USERNAME'],ENV['PASSWORD'])
    @login_search.clickLogin
    end

  And /^verify success login$/ do
    expect(@login_search).to have_no_buttonLogin
  end