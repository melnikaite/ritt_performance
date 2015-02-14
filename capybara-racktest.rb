#!/usr/bin/env ruby

require 'capybara'
require 'benchmark'
require 'bundler'
Bundler.require(:default)
require './helper'
require './capybara'

app = lambda do |env|
  host = env['HTTP_HOST'].gsub('localhost', '127.0.0.1')
  url = "#{env['rack.url_scheme']}://#{host}#{env['PATH_INFO']}"
  body = `curl -s -X #{env['REQUEST_METHOD']} #{url}`
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
