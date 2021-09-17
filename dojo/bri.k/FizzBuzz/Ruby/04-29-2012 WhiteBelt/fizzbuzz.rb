class Fizzbuzz
  def fizzbuzz
     (1...100).each{|x| puts getfizzbuzztext(x)}
  end

  def getfizzbuzztext(numberToConvert)
    is3 = divisibleByOrIncludedIn numberToConvert, 3
    is5 = divisibleByOrIncludedIn numberToConvert, 5
    is3and5 = is3 && is5
    if is3and5
      "fizzbuzz"
    elsif is3
      "fizz"
    elsif is5
      "buzz"
    else
       numberToConvert.to_s
    end
  end

  def divisibleByOrIncludedIn(number,divisor)
     number % divisor == 0 or number.to_s.include? divisor.to_s
  end

  def fizzbuzzUsingMapReduce()
    collection = (1...100).map {|x| [(x % 3 == 0),(x % 5 == 0),(x % 15 == 0),x] }
    reduction = collection.reduce  do |sum,x|
      if(sum[3] == 1)
        sum = "1"
      end
       if(x[2])
         sum = sum + ",fizzbuzz"
       elsif(x[0])
         sum = sum + ",fizz"
         elsif(x[1])
         sum = sum + ",buzz"
         else
         sum = sum +  "," + x[3].to_s
         end
  end
   puts reduction
  end
end