#puts "absolute path of dir: " + File.absolute_path("") 
#puts "dir last accessed at : " + File.atime(File.absolute_path("")).to_s
filename = "123.txt"
puts "exist? " + filename + " : " + File.exist?(filename).to_s
puts "size of " + filename + " : " + File.size(filename).to_s
#nonexistentFilename = "nonexistentFilename"
#puts "size of " + nonexistentFilename + " : " + File.size?(nonexistentFilename).to_s

file = File.open(filename)
puts "modification time of " + filename + " : " + file.mtime().to_s
#puts "path of " + filename + " : " + file.path()

#from http://stackoverflow.com/questions/5545068/what-are-all-the-common-ways-to-read-a-file-in-ruby
puts "write with a while: \n"
while (line = file.gets)
	puts line
end

#open modes: http://ruby-doc.org/core-2.2.0/IO.html#method-c-new
puts "write with a do block: \n"
File.open(filename, "r") do |f|
  f.each_line do |line|
    puts line
  end
end

puts "write with explicit close: \n"
f = File.open(filename, "r")
f.each_line do |line|
  puts line
end
f.close