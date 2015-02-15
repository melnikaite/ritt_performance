#!/usr/bin/env ruby

require 'capybara'
require 'selenium-webdriver'
require 'benchmark'
require 'bundler'
Bundler.require(:default)
require './helper'
require './capybara'

Capybara.run_server = false
Capybara.register_driver :remote_browser do |app|
  Capybara::Selenium::Driver.new(
    app,
    :browser => :remote, :url => 'http://127.0.0.1:4444/wd/hub',
    :desired_capabilities => Selenium::WebDriver::Remote::Capabilities.internet_explorer
  )
end
Capybara.default_driver = :remote_browser
include Capybara::DSL

test
