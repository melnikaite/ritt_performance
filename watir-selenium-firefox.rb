#!/usr/bin/env ruby

require 'watir-webdriver'
require 'benchmark'
require 'bundler'
Bundler.require(:default)
require './helper'
require './watir'

browser = Watir::Browser.new :firefox

test(browser)

browser.close
