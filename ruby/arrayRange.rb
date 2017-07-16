def rng (arr)
  str = arr[0].to_s #"0"
  idx = 1
  arr.each do |i| #2
    break if idx == 2
    next if arr.index(i) == 0
    if arr[arr.index(i)-1] == i - 1  #arr[1] == 1
      #unless str[idx - 1] == "-"
      if str[idx - 1] != "-" #str[2] != "-"
        str[idx] = "-" 
      else 
        next
      end
      puts "if statement str: #{str}, idx: #{idx}"
    else
      str[idx] = arr[arr.index(i)-1].to_s
      idx += 1
      str[idx] = ","+ i.to_s
      puts "else statement str: #{str}, idx: #{idx}"
    end
    idx += 1
    puts "the str is: #{str} and idx counter is #{idx}"
  end
    puts "outside the loop: str = #{str} and idx = #{idx}"
    puts "str[idx] = #{str[idx]}; str[idx].nil? = #{str[idx].nil?};"
    str[idx] = "x"
    puts "str[idx] = #{str[idx]}; str[idx].nil? = #{str[idx].nil?};"
end

rng [0, 1, 2, 3, 8] #"0-3, 8"
#rng [3, 4, 8] #yes
#rng [1, 5, 8, 10] #yes
#rng [3, 4, 5, 6, 1021, 1022] #no

#from a comment here:
# http://stackoverflow.com/questions/34981677/why-am-i-getting-an-indexerror
# :
def rng0(arr)
  ranges = []
  arr.each do |v|
    if ranges.last && ranges.last.include?(v-1)
      # If this is the next consecutive number
      # store it in the second element
      ranges.last[1] = v
    else
      # Add a new array with current value as the first number
      ranges << [v]
    end
  end
  # Make a list of strings from the ranges
  # [[0,3], [8]] becomes ["0-3", "8"]
  range_strings = ranges.map{|range| range.join('-') }
  range_strings.join(', ')
end


#p rng0 [0, 1, 2, 3, 8]
# results in "0-3, 8"
