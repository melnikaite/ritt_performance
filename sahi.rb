Sahi::Browser.class_eval do
  def fetch(expression)
    key = "___lastValue___" + Time.now.getutc.to_s;
    execute_step("_sahi.setServerVar('"+key+"', " + expression + ")")
    return check_nil(exec_command("getVariable", {"key" => key}))
  end
end

def input(i, browser)
  browser.navigate_to 'http://localhost:8080/input'
  raise unless browser.contains_text?('Performance')
  browser.textbox('text-input').value = "value#{i}"
  raise unless browser.textbox('text-input').value == Sahi::Utils.quoted("value#{i}")
end

def indexeddb(i, browser)
  url = 'http://localhost:8080/indexeddb'
  browser.navigate_to url
  browser.textbox('todo').value = "value#{i}"
  browser.submit('add-todo-item').click
  browser.navigate_to "#{url}?r=#{i}"
  raise unless browser.listItem('todoItem').text == Sahi::Utils.quoted("value#{i} [Delete]")
  browser.link('[Delete]').click
  browser.navigate_to "#{url}?r=#{i}_#{i}"
  raise if browser.listItem("value#{i}").exists1?
end

def select2(i, browser)
  browser.navigate_to "http://select2.github.io/examples.html?r=#{i}"
  raise unless browser.span('select2-selection__rendered').text == Sahi::Utils.quoted('Alaska')
  browser.span('select2-selection__rendered').click
  browser.listItem('Hawaii').click
  raise unless browser.span('select2-selection__rendered').text == Sahi::Utils.quoted('Hawaii')
end
