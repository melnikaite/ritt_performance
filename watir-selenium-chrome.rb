#!/usr/bin/env ruby

require 'watir-webdriver'
require 'benchmark'
require 'bundler'
Bundler.require(:default)
require './helper'
require './watir'

browser = Watir::Browser.new :chrome

test(browser)

browser.close
