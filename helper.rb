def start_server
  Thread.new do
    `http-server --silent`
  end

  while `curl -sL -w "%{http_code}" "localhost:8080"` == '000'
    sleep 0.1
  end
end

def stop_server
  `ps aux | grep -ie http-server | awk '{print $2}' | xargs kill -9 >/dev/null 2>/dev/null`
end

def server
  start_server
  begin
    yield
  ensure
    stop_server
  end
end

def test(browser = nil)
  server do
    %w(input indexeddb).each do |test|
      begin
        realtime = Benchmark.realtime {
          for i in 1..10 do
            send(test, i, browser)
          end
        }.to_s
      rescue
        puts "#{test} failed".red
      else
        puts "#{test} #{realtime}".green
      end
    end
  end
end