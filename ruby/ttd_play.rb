#roman numeral transator...

RomanSymbolValue = {1 => 'I', 5 => 'V', 10 => 'X', 50 => 'L', 100 => 'C', 500 => 'D', 1000 => 'M'}
RomanSymbolValue = RomanSymbolValue.to_a.reverse.to_h
def arabicToRoman(arabic)
  remaining = arabic
  convert = ''

    RomanSymbolValue.each do |k,v|
      if remaining > 4 && (remaining > k) #&& remaining <= k +3)
        remaining -=k
        convert += v
        puts convert
        break if remaining == 0
      elsif remaining == k
        remaining -= remaining
        convert += v
        puts convert
        break if remaining == 0
      elsif remaining == k - 1
          remaining -= remaining
          convert += RomanSymbolValue[1]
          convert += v
          puts convert
        break if remaining == 0
      end
      if remaining <= 3 && remaining != 0
        remaining.times do
          convert += RomanSymbolValue[1]#v
        end
      remaining -= remaining
      puts convert
      break if remaining == 0
      end
    end
  end

# arabicToRoman(1)
# arabicToRoman(2)
# arabicToRoman(3)

#arabicToRoman(4)

 #arabicToRoman(5)
# arabicToRoman(6)

# arabicToRoman(7)
# arabicToRoman(8)
# arabicToRoman(9)

#arabicToRoman(10)
# arabicToRoman(11)
# arabicToRoman(12)
# arabicToRoman(13)
# arabicToRoman(14)
 arabicToRoman(18)
#arabicToRoman(50)
arabicToRoman(59)
#q: why when i write return convert, it does not return anything in irb?
