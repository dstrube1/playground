arr1 = [1,2,3,4,5,6,7,8,9,10,11]
num1 = 7
num2 = 2
num3 = 33
num4 = 0
num = 6

def match(arr,num)
  i = arr1.length - 1
  arr_big = []
  arr_small = []
  if num > arr.last || num < arr.first
    puts "no match"
  elsif num > arr[i/2]
    arr_big = arr.select {|num| num > arr[i/2]}
  elsif num < arr[i/2]
    arr_small = arr.select {|num| num < arr[i/2]}
  else
    puts "It's a match!"
  end
end
