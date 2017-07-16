
    def rng (arr)
      str = arr[0].to_s 
      idx = 1
      arr.each do |i| 
        next if arr.index(i) == 0
        if arr[arr.index(i)-1] == i - 1  
          unless str[idx - 1] == "-"
            str[idx] = "-" 
          #else next
          end
          #puts "if statement str: #{str}, idx: #{idx}"
        else
          str[idx] = arr[arr.index(i)-1].to_s
          idx += 1
          str[idx] = ","+ i.to_s
        end
        idx += 1
      end
        puts "str = #{str} and idx = #{idx}"
    end

rng [0, 1, 2, 3, 8] #"0-3, 8"
