#!/usr/bin/env ruby

require 'capybara'
require 'benchmark'

Capybara.run_server = false
Capybara.register_driver :firefox do |app|
  Capybara::Selenium::Driver.new(app, :browser => :firefox)
end
Capybara.default_driver = :firefox

include Capybara::DSL

visit 'file://' + File.absolute_path('./fixture.html')

puts Benchmark.realtime {
  for i in 1..100 do
    raise unless page.has_content?('Performance')
    page.find('#text-input').set('value')
    raise unless page.find('#text-input').value == 'value'
  end
}
