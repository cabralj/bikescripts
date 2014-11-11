require "open-uri"
url = "http://bikepedia.com/Search.aspx?Q=90E0-7161"

source = open(url,
	"User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.111 Safari/537.36",
	
).read

#puts "--- PAGE SOURCE ---"
#puts source

links = source.scan(/<a.+?href="(.+?)".+?/)

puts "--- FOUND THIS MANY LINKS ---"
puts links.size

puts "--- PRINTING LINKS ---"
links.each do |link|
  puts "- #{link}"
end
