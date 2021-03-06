Capybara.default_wait_time = 10

def input(i, browser)
  visit "http://#{`ifconfig | grep inet | grep broadcast | cut -d ' ' -f2`.strip}:8080/input"
  raise unless page.has_content?('Performance')
  page.find('#text-input').set("value#{i}")
  raise unless page.find('#text-input').value == "value#{i}"
end

def indexeddb(i, browser)
  url = "http://#{`ifconfig | grep inet | grep broadcast | cut -d ' ' -f2`.strip}:8080/indexeddb"
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
    raise unless page.find('h1').text.include?("value#{i}")
  end
end

def angularui(i, browser)
  visit 'http://angular-ui.github.io/ui-utils/'
  raise unless page.find('#event input')
  page.find('#event input').click
  page.first('#event h3').click
  raise unless page.driver.browser.switch_to.alert.text == 'Goodbye. Input content is: Focus and then Blur this input'
  page.driver.browser.switch_to.alert.accept
end

def bootstrap(i, browser)
  visit "http://getbootstrap.com/javascript/?r=#{i}#modals"
  raise unless page.find_button('Launch demo modal')
  page.find_button('Launch demo modal').click
  within page.all('.modal-body').last do
    page.first('h4').text == 'Text in a modal'
  end
end

def d3(i, browser)
  visit 'http://mbostock.github.io/d3/talk/20111116/pack-hierarchy.html'
  raise unless page.has_selector?('circle')
  circle = page.all('circle.parent')[2]
  cx = circle['cx']
  circle.click
  raise unless page.has_no_selector?("circle[cx='#{cx}']")
end
