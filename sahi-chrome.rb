#!/usr/bin/env ruby
#cd ~/sahi_pro/userdata/bin/
#./start_dashboard.sh
#http://sahipro.com/w/browser-types-xml
#http://sahipro.com/w/ruby

require 'sahi'
require 'rack'
require 'benchmark'

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

pid = fork do
  Rack::Server.start :app => app
end

begin
  browser = Sahi::Browser.new('chrome')
  browser.open

  until browser.is_ready?
    sleep 0.1
  end

  browser.navigate_to 'http://localhost:8080'

  puts Benchmark.realtime {
    for i in 1..100 do
      raise unless browser.contains_text?('Performance')
      browser.textbox('text-input').value = 'value'
      raise unless browser.textbox('text-input').value == 'value'
    end
  }
ensure
  `kill -9 #{pid}`
  browser.close
end
