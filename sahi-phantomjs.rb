#!/usr/bin/env ruby

Thread.new do
  require 'fileutils'
  Dir.chdir("#{Dir.home}/sahi_pro/userdata/bin")
  FileUtils.chmod('+x', 'start_dashboard.sh')
  `./start_dashboard.sh >/dev/null 2>/dev/null`
end
while `curl -w %{http_code} -s --output /dev/null $1 127.0.0.1:9999` == '000'
  sleep 1
end
Dir.chdir(__dir__)

require 'sahi'
require 'benchmark'
require 'bundler'
Bundler.require(:default)
require './helper'
require './sahi'

browser = Sahi::Browser.new('phantomjs')
browser.open

test(browser)

browser.close
`ps aux | grep -ie sahi | awk '{print $2}' | xargs kill -9 >/dev/null 2>/dev/null`
