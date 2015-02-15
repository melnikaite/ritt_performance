def input(i, browser)
  visit 'http://localhost:8080/input'
  raise unless page.has_content?('Performance')
  page.find('#text-input').set("value#{i}")
  raise unless page.find('#text-input').value == "value#{i}"
end

def indexeddb(i, browser)
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

def select2(i, browser)
  visit 'http://select2.github.io/examples.html'
  raise unless page.first('.select2-selection__rendered').text == 'Alaska'
  page.first('.select2-selection__rendered').click
  page.all('.select2-results__option', text: 'Hawaii')[1].click
  raise unless page.first('.select2-selection__rendered').text == 'Hawaii'
end

def wysiwyg(i, browser)
  visit "http://ckeditor.com/demo?r=#{i}#standard"
  raise unless page.find('iframe.cke_wysiwyg_frame.cke_reset')
  within_frame(1) do
    raise unless page.find('h1').text == 'Apollo 11'
    page.find('body').set("value#{i}")
    raise unless page.find('h1').text == "value#{i}"
  end
end
