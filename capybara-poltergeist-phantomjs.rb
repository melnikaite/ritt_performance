#!/usr/bin/env ruby

require 'capybara'
require 'capybara/poltergeist'
require 'benchmark'
require 'colorize'

Capybara.run_server = false
Capybara.default_driver = :poltergeist

include Capybara::DSL

visit 'file://' + File.absolute_path('./fixture.html')

puts Benchmark.realtime {
  for i in 1..100 do
    raise unless page.has_content?('Performance')
    page.find('#text-input').set("value#{i}")
    raise unless page.find('#text-input').value == "value#{i}"
  end
}.to_s.green
