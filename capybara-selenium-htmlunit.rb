#!/usr/bin/env ruby
Thread.new { `java -jar ~/projects/selenium/selenium-server-standalone-2.44.0.jar -role hub -multiWindow >/dev/null 2>/dev/null` }
while `curl -w %{http_code} -s --output /dev/null $1 127.0.0.1:4444` == '000'
  sleep 1
end
Thread.new { `java -jar ~/projects/selenium/selenium-server-standalone-2.44.0.jar -role webdriver -hub http://127.0.0.1:4444/grid/register -port 5555 -browser browserName=htmlunit >/dev/null 2>/dev/null` }
while `curl -w %{http_code} -s --output /dev/null $1 127.0.0.1:5555` == '000'
  sleep 1
end

require 'capybara'
require 'selenium-webdriver'
require 'benchmark'
require 'bundler'
Bundler.require(:default)
require './helper'
require './capybara'

Capybara.run_server = false
Capybara.register_driver :htmlunit do |app|
  caps = Selenium::WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
  Capybara::Selenium::Driver.new(app, :browser => :remote, :desired_capabilities => caps)
end
Capybara.default_driver = :htmlunit
include Capybara::DSL

test

`ps aux | grep -ie selenium-server-standalone | awk '{print $2}' | xargs kill -9`
