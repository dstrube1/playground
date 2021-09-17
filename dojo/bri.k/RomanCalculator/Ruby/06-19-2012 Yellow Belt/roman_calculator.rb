class RomanCalculator

  @@romanNumerals = ["I","V","X","L","C","D","M"]
  @@subtractionSubs = [["IV", "IIII"],["IX", "VIIII"],["XL","XXXX"],["XC","LXXXX"],["CD","CCCC"],["CM","DCCCC"]]
  @@combinations = [["V","IIIII"],["X","VV"],["L","XXXXX"],["C","LL"],["D","CCCCC"],["M","DD"]]


  def Add(first, second)
    firstSubbed = SubstituteSubtractions first
    secondSubbed = SubstituteSubtractions second
    concatenatedNumeral = firstSubbed + secondSubbed
    sortedNumeral = Sort concatenatedNumeral
    combinedNumeral = CombineGroups sortedNumeral
    replacedSubs = ReplaceSubtractions combinedNumeral
    return replacedSubs
  end

  def SubstituteSubtractions(numeral)
    @@subtractionSubs.each do |subPair|
      numeral.gsub!(subPair[0],subPair[1])
    end
    numeral
  end

  def ReplaceSubtractions(numeral)
      @@subtractionSubs.each do |subPair|
        numeral.gsub!(subPair[1],subPair[0])
      end
    numeral
  end

  def Sort(numeral)
    i = 0
     numeral.each_char do |element|
       j = i - 1
       while j >= 0
         break if CompareNumerals(numeral[j],element) == 0
         numeral[j + 1] = numeral[j]
         j -= 1
       end
       numeral[j + 1] = element
       i += 1
     end
    return numeral
  end

  def CombineGroups(numeral)
    @@combinations.each do |subPair|
      numeral.gsub!(subPair[1],subPair[0])
    end
    numeral
  end

  def CompareNumerals(first, second)
     if(@@romanNumerals.index(first) <= @@romanNumerals.index(second))
       return -1
     end
    return 0
  end

  end