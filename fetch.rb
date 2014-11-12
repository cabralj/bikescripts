#!/usr/bin/ruby


require "open-uri"

base = "http://bikepedia.com/"
uagent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.111 Safari/537.36"
ref = "http://www.bikepedia.com/"

part = ARGV[0]
url = base + "/Search.aspx?Q=" + part

#url = "http://bikepedia.com90E0-7161"

puts "==================================="
source = open(url,
	"User-Agent" => uagent,
	"Referrer" => ref	
).read

puts "Fetch \t#{url}"

if source.include? '<span id="ctl00_MainContent_searchCountLabel">1</span></b>'
	puts "Found\t1"	
	links = source.scan(/<a.+?href="(.+?)".+?/)
	puts "==================================="
	
	#puts links.inspect

	dLink = "http://bikepedia.com" + links[42][0]
	puts "Fetch \t#{dLink}"

	detail = open(dLink,
		"User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.111 Safari/537.36",
		"Referrer" => "http://www.bikepedia.com/"	
	).read

else
	puts "Not Found"
end





