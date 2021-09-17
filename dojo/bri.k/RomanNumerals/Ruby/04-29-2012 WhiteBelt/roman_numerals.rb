class RomanNumerals
  @@converter = [[1000,"M"],[900,"CM"],[500,"D"],[400,"CD"],[100,"C"],[90,"XC"],[50,"L"],[40,"XL"],[10,"X"],[9,"IX"],[5,"V"],[4,"IV"],[1,"I"]]
  def toRoman(number)
    result = ""

    @@converter.each  do |arabic,roman|
    while(number >= arabic)
      result += roman
      number -= arabic
    end
    end
    result
  end

  def toArabic(number)
    result = 0
    prevChar = "!"
    prevRoman = "I"
    prevArabic = 0


       number.reverse.chars do |currChar|
         @@converter.reverse.each do |currArabic,currRoman|
           if(currChar == currRoman && result < 3 * currArabic)
             result += currArabic
           elsif(currChar == currRoman && result > 3 * currArabic)
             result -= currArabic
           end
           prevRoman = currRoman
           prevArabic = currArabic
         end
         prevRoman = "I"
         prevArabic = 0
         prevChar = currChar
     end
    result
  end
end