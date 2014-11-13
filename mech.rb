require 'mechanize'

part = ARGV[0]
url = "http://bikepedia.com/Search.aspx?Q=" + part

puts url

agent = Mechanize.new

page = agent.get(url)

puts page.links_with(:href => /PA/)