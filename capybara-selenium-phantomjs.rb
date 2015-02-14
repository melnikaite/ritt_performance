#!/usr/bin/env ruby

require 'capybara'
require 'benchmark'
require 'bundler'
Bundler.require(:default)
require './helper'
require './capybara'

Capybara.run_server = false
Capybara.register_driver :phantomjs do |app|
  Capybara::Selenium::Driver.new(app, :browser => :phantomjs)
end
Capybara.default_driver = :phantomjs
include Capybara::DSL

test
