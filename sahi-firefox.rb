#!/usr/bin/env ruby
Thread.new do
  require 'fileutils'
  Dir.chdir("#{Dir.home}/sahi_pro/userdata/bin")
  FileUtils.chmod('+x', 'start_dashboard.sh')
  `./start_dashboard.sh >/dev/null 2>/dev/null`
end
while `curl -sL -w "%{http_code}" "localhost:9999"` == '000'
  sleep 1
end
#https://sahipro.com/docs/sahi-apis/index.html
#http://sahipro.com/w/browser-types-xml
#http://sahipro.com/w/ruby

require 'sahi'
require 'rack'
require 'benchmark'
require 'colorize'

Sahi::Browser.class_eval do
  def fetch(expression)
    key = "___lastValue___" + Time.now.getutc.to_s;
    execute_step("_sahi.setServerVar('"+key+"', " + expression + ")")
    return check_nil(exec_command("getVariable", {"key" => key}))
  end
end

app = lambda do |env|
  Dir.chdir(__dir__)
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
  browser = Sahi::Browser.new('firefox')
  browser.open

  until browser.is_ready?
    sleep 0.1
  end

  browser.navigate_to 'http://localhost:8080'

  puts Benchmark.realtime {
    for i in 1..100 do
      raise unless browser.contains_text?('Performance')
      browser.textbox('text-input').value = "value#{i}"
      raise unless browser.textbox('text-input').value == Sahi::Utils.quoted("value#{i}")
    end
  }.to_s.green
ensure
  `kill -9 #{pid}`
  browser.close
  `ps aux | grep -ie sahi | awk '{print $2}' | xargs kill -9 >/dev/null 2>/dev/null`
end
