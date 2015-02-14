#!/usr/bin/env ruby

require 'capybara'
require 'benchmark'
require 'bundler'
Bundler.require(:default)
require './helper'
require './capybara'

app = lambda do |env|
  body = File.read("./public#{env['PATH_INFO']}.html")
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

test
