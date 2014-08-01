#!/usr/bin/env ruby

require 'watir-webdriver'
require 'benchmark'

browser = Watir::Browser.new :phantomjs

browser.goto 'file://' + File.absolute_path('./fixture.html')

puts Benchmark.realtime {
  for i in 1..100 do
    raise unless browser.text.include?('Performance')
    browser.text_field(:id => 'text-input').set('value')
    raise unless browser.text_field(:id => 'text-input').value == 'value'
  end
}

browser.close
