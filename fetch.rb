
require 'open-uri'

require 'net/http'
require 'uri'


part = ARGV[0]
url = "http://bikepedia.com/Search.aspx?Q=" + part

def open(u)
	puts "Fetching\n" + u
	Net::HTTP.get(URI.parse(u))
end

def saveImg()
	File.open('pie.png', 'wb') do |fo|
	  fo.write open("http://chart.googleapis.com/chart?").read 
	end
end


puts logo


page = open(url)
image = saveImg()

if page.include? '<span id="ctl00_MainContent_searchCountLabel">1</span></b>'
	puts "1 Match"
else
	puts "0 or more"
end
