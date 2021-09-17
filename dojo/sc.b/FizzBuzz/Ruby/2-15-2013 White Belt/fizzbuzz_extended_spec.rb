require "rspec"
require "./FizzBuzz/fizzbuzzextended"

describe "For numbers 1..15" do

  results = FizzBuzzExtended.new.print(1..15)

  it "should print known values" do
    results.should == [1,2,"Fizz",4,"Buzz","Fizz",7,8,"Fizz","Buzz",11,"Fizz","Fizz",14,"FizzBuzz"]
  end
end

describe "For numbers 30..40" do
  results = FizzBuzzExtended.new.print(30..40)

  it "should print known values" do
    results.should == ["FizzBuzz","Fizz","Fizz","Fizz","Fizz","FizzBuzz","Fizz","Fizz","Fizz","Fizz","Buzz"]
  end
end

describe "For numbers 50..60" do
  results = FizzBuzzExtended.new.print(50..60)

  it "should print known values" do
    results.should == ["Buzz","FizzBuzz","Buzz","FizzBuzz","FizzBuzz","Buzz","Buzz","FizzBuzz","Buzz","Buzz","FizzBuzz"]
  end
end