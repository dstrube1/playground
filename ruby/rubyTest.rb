class Class1

  @hey = nil

  def set_hey
    @hey = "blah1"
  end

  def print_hey
    puts "hey from Class1: #{@hey}"
  end

  def get_hey
    return @hey #maybe?
  end

end

class Class2

  @foo = nil

  def set_foo_from_hey
    temp2 = Class1.new
    @foo = temp2.get_hey
  end

  def did_it_work
    puts "hey from Class1 = #{@foo}"
  end

end

#temp1 = Class1.new
#temp1.set_hey
#temp1.print_hey

#temp3 = Class2.new
#temp3.set_foo_from_hey
#temp3.did_it_work

#puts "temp1.get_hey = #{temp1.get_hey}"

def blah(opt=nil)
puts "opt is #{opt}"
end
blah
blah("hey")
blah({})

