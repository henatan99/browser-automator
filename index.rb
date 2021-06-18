require 'watir'
require 'webdrivers'

account = File.open("account.txt")
lines = account.readlines
EMAIL = lines[0]
puts EMAIL
PASSWORD = lines[1]
puts PASSWORD

def browser_auto
  client = Selenium::WebDriver::Remote::Http::Default.new
  client.read_timeout = 300 # seconds
  driver = Selenium::WebDriver.for :chrome,http_client: client

  browser = Watir::Browser.new
  browser.goto('https://dashboard.microverse.org/review_requests')

  browser.text_field(id: '1-email').set EMAIL
  browser.text_field(type: 'password').set PASSWORD
  browser.button(type: 'submit').click
  browser.link(:text =>"Review Requests 2.0").click

  counter = 0
  loop do
      begin
        sleep(0.2)
        target_text = browser.span(class:'review-request-announcement-header').text 
        browser.button(:text => 'Claim').click if target_text != 'No Available Reviews'
        puts target_text 
      rescue
        puts "Nothing"
      end
      if (counter >= 50) 
        browser.refresh 
        counter = 0
      else 
        counter += 1
      end 
  end

  sleep(5)

  browser.close
end 

read_timeouts = 0
begin 
  browser_auto
  rescue Net::ReadTimeout
    STDOUT.puts 'Net::ReadTimeout during browser launch. Trying to launch the browser again'
    read_timeouts += 1
    unless read_timeouts > 20
      browser_auto
    end
end 