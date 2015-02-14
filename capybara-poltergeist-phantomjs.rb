#!/usr/bin/env ruby

require 'capybara'
require 'capybara/poltergeist'
require 'benchmark'
require 'bundler'
Bundler.require(:default)
require './helper'
require './capybara'

Capybara.run_server = false
Capybara.default_driver = :poltergeist
include Capybara::DSL

test
