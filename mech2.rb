require 'rubygems'
require 'mechanize'


part = ARGV[0]
url = "http://bikepedia.com/Search.aspx?Q=" + part


agent = Mechanize.new
agent.set_proxy('localhost', '8000')
agent.user_agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.111 Safari/537.36'
agent.user_agent_alias = 'Linux Mozilla'
agent.open_timeout = 3
agent.read_timeout = 4
agent.keep_alive = false


page = agent.get(url)
