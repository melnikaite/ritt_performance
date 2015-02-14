#!/usr/bin/env ruby

require 'capybara-webkit'
require 'benchmark'
require 'colorize'

Capybara.run_server = false
Capybara.default_driver = :webkit

include Capybara::DSL

page.driver.allow_url('')
visit 'file://' + File.absolute_path('./fixture.html')

puts Benchmark.realtime {
  for i in 1..100 do
    raise unless page.has_content?('Performance')
    page.find('#text-input').set("value#{i}")
    raise unless page.find('#text-input').value == "value#{i}"
  end
}.to_s.green
