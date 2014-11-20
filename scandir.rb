
# Scans a directory for an existing Part #

require "fileutils"

def scanDirByPart(fid, pid)
	Dir.glob("data/*.txt") do |text_file|
	    if open(text_file).grep(/#{pid}/).size > 0
	    	f = File.readlines(text_file)[0]
	    	desFile = "./data/" + fid + ".txt"
	    	srcFile = "./data/" + f.split("=").last.strip + ".txt"

	    	puts desFile
	    	puts srcFile

	    	FileUtils.cp(srcFile, desFile)
	    	break
	    end 
	end
end


def scanDirByUPC(fid, pid)
	puts fid.to_s.strip + " " + pid
end
