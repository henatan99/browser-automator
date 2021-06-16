require 'watir'
require 'webdrivers'

account = File.open('account.txt')
lines = account.readlines
email = lines[0]
puts email
password = lines[1]
puts password

browser = Watir::Browser.new
browser.goto('https://dashboard.microverse.org/review_requests')

browser.text_field(id: '1-email').set email
browser.text_field(type: 'password').set password
browser.button(type: 'submit').click
browser.link(text: 'Review Requests 2.0').click

loop do
  sleep(1)
  puts 'You got a CR' + browser.button(text: 'Claim').click
rescue StandardError
  puts 'Nothing'
end

sleep(12)

browser.close
