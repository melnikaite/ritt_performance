#!/usr/bin/env ruby
Thread.new { `java -jar ~/projects/selenium/selenium-server-standalone-2.44.0.jar -role hub -multiWindow >/dev/null 2>/dev/null` }
while `curl -sL -w "%{http_code}" "localhost:4444" -o /dev/null` == '000'
  sleep 1
end
Thread.new { `java -jar ~/projects/selenium/selenium-server-standalone-2.44.0.jar -role webdriver -hub http://127.0.0.1:4444/grid/register -port 5555 -browser browserName=htmlunit >/dev/null 2>/dev/null` }
while `curl -sL -w "%{http_code}" "localhost:5555" -o /dev/null` == '000'
  sleep 1
end

require 'capybara'
require 'selenium-webdriver'
require 'benchmark'
require 'colorize'

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
    page.find('#text-input').set("value#{i}")
    raise unless page.find('#text-input').value == "value#{i}"
  end
}.to_s.green

`ps aux | grep -ie selenium-server-standalone | awk '{print $2}' | xargs kill -9`
