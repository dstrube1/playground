arr1 = [3,4,5,6,8,9,10,11,99,1,2]
num = 6 #res - [index of 6]
num1 = 7 #res - no match
num2 = 2 #res - [index of 2]
num3 = 33 #res - no match
num4 = 0 #res - no match
num5 = 4 #res - [index of 4]
num6 = 1 #res - [index of 1]

begNum = 0
endNum = arr.length - 1

def match(arr, num, begNum, endNum)
# function takes in a rotated integer array and a number to see if
# the number exists in the array.

#requires recursion
  arr_left = []
  arr_right = []
#  mid = endNum / 2
  
  if num > arr.last || num < arr.first
    puts "no match"
  elsif num > arr[mid]
    arr_big = arr.select {|x| x > arr[size/2]}
    match(arr_big,num, begNum, )
  elsif num < arr[size/2]
    arr_small = arr.select {|x| x < arr[size/2]}
    match(arr_small,num)
  else
    puts "It's a match!"
  end
end

match(arr1,num,begNum,endNum)