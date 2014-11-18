


Dir.glob("data/*.txt") do |text_file|
    if a = open(text_file).grep(/14-14/).size > 0
        puts "found in = " + text_file
    end 
end
