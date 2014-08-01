#!/usr/bin/env ruby
#java -jar ~/projects/selenium/selenium-server-standalone-2.41.0.jar -role hub -multiWindow
#java -jar ~/projects/selenium/selenium-server-standalone-2.41.0.jar -role webdriver -hub http://127.0.0.1:4444/grid/register -port 5555 -browser browserName=htmlunit

require 'capybara'
require 'selenium-webdriver'
require 'benchmark'

Capybara.run_server = false
Capybara.register_driver :htmlunit do |app|
  caps = Selenium::WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
  Capybara::Selenium::Driver.new(app, :browser => :remote, :desired_capabilities => caps)
end
Capybara.default_driver = :htmlunit

include Capybara::DSL

visit 'file://' + File.absolute_path('./fixture.html')

puts Benchmark.realtime {
  for i in 1..100 do
    raise unless page.has_content?('Performance')
    page.find('#text-input').set('value')
    raise unless page.find('#text-input').value == 'value'
  end
}
