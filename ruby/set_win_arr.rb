@win = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]

def set_win_arr(player_move, player)
  @win.each do |combo|
	  puts "combo is " + combo.to_s
	  combo.each do |space|
		  puts "space is " + space.to_s
		  if combo[space] == player_move
			  combo[space] = player
		  end
	  end
  end
end

set_win_arr(1,'x')
puts @win