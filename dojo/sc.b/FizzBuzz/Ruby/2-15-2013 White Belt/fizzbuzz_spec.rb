require "rspec"
require "./FizzBuzz/fizzbuzz"

describe "For numbers 1..15" do

  results = FizzBuzz.new.print(1..15)

  it "should print known values" do
    results.should == [1,2,"Fizz",4,"Buzz","Fizz",7,8,"Fizz","Buzz",11,"Fizz",13,14,"FizzBuzz"]
  end
end