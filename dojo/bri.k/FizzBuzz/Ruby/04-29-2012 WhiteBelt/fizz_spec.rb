require 'rspec'
require File.dirname(__FILE__) + '/fizzbuzz'

describe Fizzbuzz, "#getfizzbuzztext" do
  it "returns fizz for 3" do
  sut = Fizzbuzz.new

  value = sut.getfizzbuzztext(3)

  value.should == "fizz"
  end

  it "returns buzz for 5" do
    sut = Fizzbuzz.new

    value = sut.getfizzbuzztext(5)

    value.should == "buzz"
  end

  it "returns fizzbuzz for 15" do
    sut = Fizzbuzz.new

    value = sut.getfizzbuzztext(15)

    value.should == "fizzbuzz"
  end

  it "returns fizz for 13"  do
    sut = Fizzbuzz.new

    value = sut.getfizzbuzztext(13)

    value.should == "fizz"
  end

  it "returns buzz for 52"  do
    sut = Fizzbuzz.new

    value = sut.getfizzbuzztext(52)

    value.should == "buzz"
  end

  it "returns fizzbuzz for 53" do
    sut = Fizzbuzz.new

    value = sut.getfizzbuzztext(53)

    value.should == "fizzbuzz"
  end

  it "returns 16 for 16" do
    sut = Fizzbuzz.new

    value = sut.getfizzbuzztext(16)

    value.should == "16"
  end
end
