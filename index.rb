require 'watir'
require 'webdrivers'

account = File.open("account.txt")
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
browser.link(:text =>"Review Requests 2.0").click

loop do
    begin
      sleep(1)
      target_text = browser.span(class:'review-request-announcement-header').text 
      browser.button(:text => "Claim").click if browser.button(:text => "Claim")
      puts target_text 
    rescue
      puts "Nothing"
    end
end

sleep(120)

browser.close
