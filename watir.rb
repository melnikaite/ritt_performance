def input(i, browser)
  browser.goto 'http://localhost:8080/input'
  raise unless browser.text.include?('Performance')
  browser.text_field(:id => 'text-input').set("value#{i}")
  raise unless browser.text_field(:id => 'text-input').value == "value#{i}"
end

def indexeddb(i, browser)
  url = 'http://localhost:8080/indexeddb'
  browser.goto url
  browser.text_field(:id => 'todo').set("value#{i}")
  browser.button(:id => 'add-todo-item').click
  browser.goto "#{url}?r=#{i}"
  raise unless browser.li(:text => "value#{i} [Delete]").exists?
  browser.a(:text => '[Delete]').click
  browser.goto "#{url}?r=#{i}_#{i}"
  raise if browser.li(:text => "value#{i} [Delete]").exists?
end