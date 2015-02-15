def input(i, browser)
  browser.goto 'http://localhost:8080/input'
  raise unless browser.text.include?('Performance')
  browser.text_field(id: 'text-input').set("value#{i}")
  raise unless browser.text_field(id: 'text-input').value == "value#{i}"
end

def indexeddb(i, browser)
  url = 'http://localhost:8080/indexeddb'
  browser.goto url
  browser.text_field(id: 'todo').set("value#{i}")
  browser.button(id: 'add-todo-item').click
  browser.goto "#{url}?r=#{i}"
  raise unless browser.li(text: "value#{i} [Delete]").exists?
  browser.a(text: '[Delete]').click
  browser.goto "#{url}?r=#{i}_#{i}"
  raise if browser.li(text: "value#{i} [Delete]").exists?
end

def select2(i, browser)
  browser.goto 'http://select2.github.io/examples.html'
  raise unless browser.span(class: 'select2-selection__rendered').text == 'Alaska'
  browser.span(class: 'select2-selection__rendered').click
  browser.li(class: 'select2-results__option', text: 'Hawaii').click
  raise unless browser.span(class: 'select2-selection__rendered').text == 'Hawaii'
end

def wysiwyg(i, browser)
  browser.goto "http://ckeditor.com/demo?r=#{i}#standard"
  Watir::Wait.until do
    browser.iframe(title: 'Rich Text Editor, editor1').h1(text: 'Apollo 11').exists?
  end
  browser.iframe(title: 'Rich Text Editor, editor1').send_keys "value#{i}"
  raise unless browser.iframe(title: 'Rich Text Editor, editor1').h1(text: "value#{i} Apollo 11").exists?
end

def angularui(i, browser)
  browser.goto 'http://angular-ui.github.io/ui-utils/'
  raise unless browser.section(id: 'event').input.exists?
  browser.section(id: 'event').input.click
  browser.section(id: 'event').h3.click
  raise unless browser.alert.text == 'Goodbye. Input content is: Focus and then Blur this input'
  browser.alert.ok
end

def bootstrap(i, browser)
  browser.goto "http://getbootstrap.com/javascript/?r=#{i}#modals"
  raise unless browser.button(text: 'Launch demo modal').exists?
  browser.button(text: 'Launch demo modal').click
  Watir::Wait.until do
    browser.divs(class: 'modal-body')[1].h4.text == 'Text in a modal'
  end
end
