#!/usr/bin/env ruby

require 'capybara-webkit'
require 'benchmark'
require 'bundler'
Bundler.require(:default)
require './helper'
require './capybara'

Capybara.run_server = false
Capybara.default_driver = :webkit
include Capybara::DSL

page.driver.allow_url('')

test
