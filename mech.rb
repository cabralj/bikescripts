require 'open-uri'
require 'mechanize'

fid = ARGV[0].to_s
part = ARGV[1].to_s
upc  = ARGV[2].to_s

urla  = "http://bikepedia.com/Search.aspx?Q="+part
urlb  = "http://bicyclehabitat.com/sitesearch.cfm?search="+upc+"&goSiteSearch.x=0&goSiteSearch.y=0"

puts "Checking bikepedia.com"
puts "\t" + urla

agent = Mechanize.new
agent.user_agent_alias = 'Mac Safari'



##############################################################
#
# =>   BikePedia
#
##############################################################


page = agent.get(urla)

result = page.at('#ctl00_MainContent_searchCountLabel').text.strip

if result.to_i > 0
	puts "\tFound " + result

	link = page.at('#ctl00_MainContent_searchResultsListView_ctrl0_HyperLink1').attributes['href']
	puts "\thttp://bikepedia.com" + link

	detail = agent.get(link)

	if (detail.at('#ctl00_MainContent_TitleOfBike_yearLabel2'))


		# Modify the image url to get a larger size
		image = detail.at('#MainImage').attributes['src'].to_s
		image.sub! 'w=250', 'w=600'
		image.sub! 'h=250', ''
		
		# Save the image with the Part Number as the File Name
		agent.get(image).save "data/"+fid+".jpg"
		puts "\tSaved Image .. " + image

		# Extract key data from page
		year  = detail.at('#ctl00_MainContent_TitleOfBike_yearLabel2').text.strip
		brand = detail.at('#ctl00_MainContent_TitleOfBike_brandLabel2').text.strip
		model = detail.at('#ctl00_MainContent_TitleOfBike_modelLabel2').text.strip
		price = detail.at('#ctl00_MainContent_DetailsView1_Label1').text.strip

		# Create a file with the Part Number as the File name
		filename = "data/"+fid+".txt"
		file = File.new(filename, "w")

		file.puts("fid = " + fid)
		file.puts("part = " + part)
		file.puts("upc = " + upc)
		file.puts("year = " + year)
		file.puts("brand = " + brand)
		file.puts("model = " + model)

		color = [(print 'Color: '), STDIN.gets.rstrip][1]
		file.puts("color = " + color)
		size = [(print 'Size: '), STDIN.gets.rstrip][1]
		file.puts("size = " + size)
		speed = [(print 'Speed: '), STDIN.gets.rstrip][1]
		file.puts("speed = " + speed)
		gender = [(print 'Gender: '), STDIN.gets.rstrip][1]
		file.puts("gender = " + gender)
		type = [(print 'Type: '), STDIN.gets.rstrip][1]
		file.puts("type = " + type)

		file.puts("price = " + price)
		file.puts("link = " + detail.uri.to_s)

		file.close
		puts "\tSaved Data ... " + filename


	else

		##############################################################
		#
		# =>   Bikepedia Detail Page
		#
		##############################################################

		puts "\tEmpty Detail Page"
		
		image = page.at('#ctl00_MainContent_searchResultsListView_ctrl0_Image1').attributes['src'].to_s
		image.sub! 'w=80', 'w=600'
		image.sub! 'h=80', ''
		agent.get(image).save "data/"+fid+".jpg"
		puts "\tSaved Image .. " + image


		full = page.at('#ctl00_MainContent_searchResultsListView_ctrl0_Label1').text.strip
		puts full

		filename = "data/"+fid+".txt"
		file = File.new(filename, "w")
		
		file.puts("fid = " + fid.to_s)
		file.puts("part = " + part.to_s)
		file.puts("upc = " + upc.to_s)
		
		year = [(print 'Year: '), STDIN.gets.rstrip][1]
		file.puts("year = " + year.to_s)

		brand = [(print 'Brand: '), STDIN.gets.rstrip][1]
		file.puts("brand = " + brand.to_s)

		model = [(print 'Model: '), STDIN.gets.rstrip][1]
		file.puts("model = " + model.to_s)

		color = [(print 'Color: '), STDIN.gets.rstrip][1]
		file.puts("color = " + color.to_s)

		size = [(print 'Size: '), STDIN.gets.rstrip][1]
		file.puts("size = " + size.to_s)

		speed = [(print 'Speed: '), STDIN.gets.rstrip][1]
		file.puts("speed = " + speed.to_s)

		gender = [(print 'Gender: '), STDIN.gets.rstrip][1]
		file.puts("gender = " + gender.to_s)

		type = [(print 'Type: '), STDIN.gets.rstrip][1]
		file.puts("type = " + type.to_s)

		price = [(print 'Price: '), STDIN.gets.rstrip][1]
		file.puts("price = " + price.to_s)

		file.puts("link = " + detail.uri.to_s)
		file.close
		puts "\tSaved Data ... " + filename

	end

else

	##############################################################
	#
	# =>   Bike Habitat
	#
	##############################################################

	puts "\tNot Found"
	puts "Checking bicyclehabitat.com"
	habitat = agent.get(urlb)
	#puts habitat.inspect
	puts "\t" + urlb
	
	if habitat.body.include? '1 Results'
		puts "Found 1"
		link = habitat.at(".seitempicture a").attributes['href']
		puts "link"

		detail = agent.get(link)

		# Find and Save Image
		image = detail.at('.meta link').attributes['href']
		image = "http://bicyclehabitat.com" + image.to_s
		image.sub! '/large/', '/zoom/'
		agent.get(image).save "data/"+fid+".jpg"

		puts "Saved Image .. " + image

		puts "title = " + detail.title
	
		year = detail.at('.semodelyear').text.strip
		puts "year = " + year

		brand = detail.at('#seitemcontent h1').text.strip
		puts "brand = " + brand

		model = detail.at('#seitemcontent h2').text.strip
		puts "model = " + model
		
		price = detail.at('.seoriginalprice').text.strip
		puts "price = " + price


		# Create a file with the Part Number as the File name
		filename = "data/"+fid+".txt"
		file = File.new(filename, "w")
		file.puts("fid = " + fid)
		file.puts("part = " + part)
		file.puts("upc = " + upc)
		file.puts("year = " + year)
		file.puts("brand = " + brand)
		file.puts("model = " + model)

		color = [(print 'Color: '), STDIN.gets.rstrip][1]
		file.puts("color = " + color)
		
		size = [(print 'Size: '), STDIN.gets.rstrip][1]
		file.puts("size = " + size)
		
		speed = [(print 'Speed: '), STDIN.gets.rstrip][1]
		file.puts("speed = " + speed)
		
		gender = [(print 'Gender: '), STDIN.gets.rstrip][1]
		file.puts("gender = " + gender)
		
		type = [(print 'Type: '), STDIN.gets.rstrip][1]
		file.puts("type = " + type)

		file.puts("price = " + price)
		file.puts("link = " + detail.uri.to_s)
		file.close
		puts "Saved Data ... " + filename

	else

		##############################################################
		#
		# =>   Manual Entry
		#
		##############################################################

		# Create a file with the Store Number as the File name
		filename = "data/"+fid+".txt"
		file = File.new(filename, "w")

		file.puts("fid = " + fid)
		file.puts("part = " + part)
		file.puts("upc = " + upc)

		year = [(print 'Year: '), STDIN.gets.rstrip][1]
		file.puts("year = " + year.to_s)

		brand = [(print 'Brand: '), STDIN.gets.rstrip][1]
		file.puts("brand = " + brand.to_s)

		model = [(print 'Model: '), STDIN.gets.rstrip][1]
		file.puts("model = " + model.to_s)

		color = [(print 'Color: '), STDIN.gets.rstrip][1]
		file.puts("color = " + color.to_s)

		size = [(print 'Size: '), STDIN.gets.rstrip][1]
		file.puts("size = " + size.to_s)

		speed = [(print 'Speed: '), STDIN.gets.rstrip][1]
		file.puts("speed = " + speed.to_s)

		gender = [(print 'Gender: '), STDIN.gets.rstrip][1]
		file.puts("gender = " + gender.to_s)

		type = [(print 'Type: '), STDIN.gets.rstrip][1]
		file.puts("type = " + type.to_s)

		price = [(print 'Price: '), STDIN.gets.rstrip][1]
		file.puts("price = " + price.to_s)

		link = [(print 'Link: '), STDIN.gets.rstrip][1]
		file.puts("link = " + link.to_s)

		file.close
		puts "Saved Data ... " + filename


	end

	# http://agees.com/sitesearch.cfm?search=791964420347&goSiteSearch.x=0&goSiteSearch.y=0

end
