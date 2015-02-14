#!/usr/bin/env ruby

require 'capybara'
require 'benchmark'
require 'colorize'

app = lambda do |env|
  body = File.read('./fixture.html')
  [
    200,
    {
      'Content-Type' => 'text/html',
      'Content-Length' => body.length.to_s
    },
    [body]
  ]
end

Capybara.run_server = true
Capybara.app = app
Capybara.register_driver :rack_test do |app|
  Capybara::RackTest::Driver.new(app)
end
Capybara.default_driver = :rack_test

include Capybara::DSL

visit '/'

puts Benchmark.realtime {
  for i in 1..100 do
    raise unless page.has_content?('Performance')
    page.find('#text-input').set("value#{i}")
    raise unless page.find('#text-input').value == "value#{i}"
  end
}.to_s.green
