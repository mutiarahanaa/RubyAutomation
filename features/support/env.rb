require 'capybara/cucumber'
require 'capybara-screenshot/cucumber'
require 'capybara/rspec'
require 'selenium-webdriver'
require 'securerandom'
require 'site_prism'
require 'dotenv'
require 'dotenv/load'


Dotenv.load

browser = (ENV['BROWSER'] || 'firefox').to_sym
wait_time = 30

Capybara.register_driver :firefox do |app|
  profile = Selenium::WebDriver::Firefox::Profile.new
  profile['general.useragent.override'] = 'selenium'
  options = Selenium::WebDriver::Firefox::Options.new
  options.profile = profile
  client = Selenium::WebDriver::Remote::Http::Default.new
  client.open_timeout = wait_time
  client.read_timeout = wait_time
  Capybara::Selenium::Driver.new(
    app,
    browser: :firefox,
    options: options,
    http_client: client
  )
end

Capybara.register_driver :chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument("--user-agent=selenium")
  client = Selenium::WebDriver::Remote::Http::Default.new
  client.open_timeout = wait_time
  client.read_timeout = wait_time
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options,
    http_client: client
  )
end

Capybara::Screenshot.register_driver(browser) do |driver, path|
  driver.browser.save_screenshot path
end

Capybara.default_driver = browser
Capybara::Screenshot.autosave_on_failure = false

Capybara::Screenshot.prune_strategy = { keep: 50 }
Capybara::Screenshot.append_timestamp = true

Before do
  Capybara.app_host = ENV['BASE_URL']
  Capybara::Screenshot.autosave_on_failure = true
  Capybara::Screenshot.webkit_options = {
    width: 1366,
    height: 768
  }
  Capybara.save_path = 'screenshots'

  page.driver.browser.manage.window.resize_to(1366, 768)
end


After do |scenario|
  if scenario.failed?
    timestamp = "#{Time.now.getutc}"
    screenshot_name = "screenshot-#{scenario}-#{timestamp}.png"
    screenshot_path = "#{screenshot_name}"
    Capybara.page.save_screenshot(screenshot_path)
    puts scenario
  end
end