require "rspec"
require File.dirname(__FILE__) + '/roman_numerals'

describe RomanNumerals, "Convert Roman Numerals to Arabic Numbers And Vice Versa" do
  it "arabic values should be converted to correct roman numerals" do
    sut = RomanNumerals.new

    data = [[1,"I"],[2,"II"],[3,"III"],[4,"IV"],[5,"V"],[6,"VI"],[7, "VII"],[8,"VIII"],[9,"IX"],[10,"X"],[14,"XIV"],[18,"XVIII"],[23,"XXIII"],[1990,"MCMXC"],[2008,"MMVIII"]]

    data.each {|arabic,roman| sut.toRoman(arabic).should == roman}

    end
  it "roman numerals should be converted to correct arabic values" do
  sut = RomanNumerals.new

  data = [[2,"II"],[4,"IV"],[5,"V"],[6,"VI"],[7, "VII"],[8,"VIII"],[9,"IX"],[10,"X"],[14,"XIV"],[18,"XVIII"],[23,"XXIII"],[1990,"MCMXC"],[2008,"MMVIII"]]#

  data.each {|arabic,roman| sut.toArabic(roman).should == arabic}

  end
end