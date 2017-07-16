arr1 = [3,4,5,6,7,8,1,2]

def split_arr(arr)
   arr_left = []
   arr_right = []
   #not right: this puts 6,7,8 in left and 3,4,1,2 in right
#   arr_left = arr.select {|x| x > arr.index(arr.length-1/2)}
#   arr_right = arr.select {|x| x < arr.index(arr.length-1/2)}
#this puts: 1,2 in left and 3,4,5,6,7 in right
	#arr_left = arr.select {|x| arr.index(x) > arr.index(arr.length-1/2)}
	#arr_right = arr.select {|x| arr.index(x) < arr.index(arr.length-1/2)}
	arr_left = arr[0,(arr.length/2)]
	arr_right = arr[(arr.length/2), (arr.length/2)] #arr.length-1]
#this puts: [nil]
#	arr_right << arr[arr.length-1/2]
   puts "arr_left = #{arr_left}"
   puts "arr_right = #{arr_right}" 
   num = arr[arr.length-1/2] 
   puts "arr[arr.length-1/2] = #{arr[arr.length-1/2]}" #nothing
   puts "num = #{num}" #nothing
   puts "arr.length = #{arr.length}" #8
   puts "arr.length-1 = #{arr.length-1}" #7
   puts "arr.length-1/2 = #{arr.length-1/2}" #8
   puts "(arr.length-1)/2 = #{(arr.length-1)/2}" #3
   arr_right << arr[(arr.length-1)/2]
	puts "arr_right = #{arr_right}"   
end

split_arr(arr1)