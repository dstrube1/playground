require "rspec"
require File.dirname(__FILE__) + '/roman_calculator'

describe RomanCalculator, "Add to Roman Numerals to produce a sum" do

  it "I plus I should equal II" do

    sut = RomanCalculator.new

    sut.Add("I","I").should == "II"
  end

  it "II plus II should equal IV" do

    sut = RomanCalculator.new

    sut.Add("II","II").should == "IV"
  end

  it "I plus IV should equal V" do

    sut = RomanCalculator.new

    sut.Add("I","IV").should == "V"
  end

  it "CCCLXIX plus DCCCXLV should equal MCCXIV" do

    sut = RomanCalculator.new

    sut.Add("CCCLXIX","DCCCXLV").should == "MCCXIV"
  end
end

describe RomanCalculator, "Substitute for subtractions" do
  it "IX should be subtracted to VIIII" do
    sut = RomanCalculator.new

    sut.SubstituteSubtractions("IX").should == "VIIII"
  end

  it "CCCLXIX should be subtracted to CCCLXVIIII" do
    sut = RomanCalculator.new

    sut.SubstituteSubtractions("CCCLXIX").should == "CCCLXVIIII"
  end

  it "DCCCXLV should be subtracted to DCCCXXXXV" do
    sut = RomanCalculator.new

    sut.SubstituteSubtractions("DCCCXLV").should == "DCCCXXXXV"
  end
end

describe RomanCalculator, "Sort numerals" do
it "CCCLXVIIIIDCCCXXXXV should be sorted to DCCCCCCLXXXXXVVIIII" do
 sut = RomanCalculator.new

  sut.Sort("CCCLXVIIIIDCCCXXXXV").should == "DCCCCCCLXXXXXVVIIII"
end

  it "VXXI should be sorted to XXVI" do
    sut = RomanCalculator.new

    sut.Sort("VXXI").should == "XXVI"
  end
end


describe RomanCalculator, "Combine numeral groups" do
  it "DCCCCCCLXXXXXXIIII should be combined to MCCXIIII" do
    sut = RomanCalculator.new

    sut.CombineGroups("DCCCCCCLXXXXXXIIII").should == "MCCXIIII"
  end
end

describe RomanCalculator, "Replace subtractions" do
  it "MCCXIIII should be replaced to MCCXIV" do
    sut = RomanCalculator.new

    sut.ReplaceSubtractions("MCCXIIII").should == "MCCXIV"
  end
end