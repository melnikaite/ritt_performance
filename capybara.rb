def input(i)
  visit 'http://localhost:8080/input'
  raise unless page.has_content?('Performance')
  page.find('#text-input').set("value#{i}")
  raise unless page.find('#text-input').value == "value#{i}"
end

def indexeddb(i)
  url = 'http://localhost:8080/indexeddb'
  visit url
  page.find('#todo').set("value#{i}")
  page.find_button('add-todo-item').click
  visit "#{url}?r=#{i}"
  raise unless page.first('li', text: "value#{i}")
  page.find_link('[Delete]').click
  visit "#{url}?r=#{i}_#{i}"
  raise if page.first('li', text: "value#{i}")
end
