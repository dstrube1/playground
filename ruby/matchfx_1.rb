arr1 = [1,2,3,4,5,6,8,9,10,11,99]
num1 = 7 #res - no match
num2 = 2 #res - It's a match
num3 = 33 #res - no match
num4 = 0 #res - no match
num = 6 #res - It's a match

# function takes in a sorted distinct integer array and a number to see if
# the number exists in the array.

#requires recursion

def match(arr,num)
  size = arr.length - 1 #i represents the index of an array
  arr_big = []
  arr_small = []
  if num > arr.last || num < arr.first
    puts "no match"
  elsif num > arr[size/2]
    arr_big = arr.select {|x| x > arr[size/2]}
    match(arr_big,num)
  elsif num < arr[size/2]
    arr_small = arr.select {|x| x < arr[size/2]}
    match(arr_small,num)
  else
    puts "It's a match!"
  end
end

match(arr1,num3)