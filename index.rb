require 'watir'
require 'webdrivers'

browser = Watir::Browser.start 'watir.com/examples/simple_form.html'

header = browser.element(id: 'user')
header.present? # => true
header.text == 'Add user' # => true
header.attribute('data-test') == 'header' # => true
header.click

browser.close
