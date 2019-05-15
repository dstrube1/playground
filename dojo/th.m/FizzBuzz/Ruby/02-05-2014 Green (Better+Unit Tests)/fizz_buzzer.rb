class Integer
  def fizzbuzz()
    value = ((self%3==0 ? "Fizz" : "") + (self%5==0 ? "Buzz" : ""))
    value != "" ? value : self
  end
end

class Range
  def fizzbuzz()
    self.each do
      |x|
      puts x.fizzbuzz if x.is_a? Integer
      x.fizzbuzz if !(x.is_a? Integer)
    end
  end
end

class Array
  def fizzbuzz()
    self.each do
      |x|
      puts x.fizzbuzz if x.is_a? Integer
      x.fizzbuzz if !(x.is_a? Integer)
    end
  end
end