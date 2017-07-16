
def open_macbeth
  filename = 'macbeth.rb'
  file = File.open(filename,'r+')
  remove_special_char(file)
end

#remove all special chars from words within string
def remove_special_char(line)
  line_new = ""
  line.each do |row|
    line_new += row.gsub(/[!.,?;]/,'') + ' '
  end
  #puts "line_new from remove_special_char" + line_new
  remove_small_words(line_new)
end

#^ 10 mins

#remove all text < 4 chars
def remove_small_words(line)
line_new4 = ""
line_arr = line.split
line_arr.each do |row|
  if row.length > 4
    line_new4 += row + ' '
  end
end
puts "line_new4 from remove_small_words: " + line_new4
#second_most_frequent_word(line_new4)
end

#^12 mins

#get 2nd most frequent word from new text
# get a count of all the words in the text...
def second_most_frequent_word(line)
  line_arr = line.split
  line_hash = []
  line_arr.each do |word|
    line_hash[word] += 1
  end
  line_hash.invert.sort[-2][1]
  #puts line_hash
end

#6 mins
open_macbeth