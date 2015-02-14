#!/usr/bin/env ruby

require 'capybara'
require 'benchmark'
require 'bundler'
Bundler.require(:default)
require './helper'
require './capybara'

Capybara.run_server = false
Capybara.register_driver :firefox do |app|
  Capybara::Selenium::Driver.new(app, :browser => :firefox)
end
Capybara.default_driver = :firefox
include Capybara::DSL

test
