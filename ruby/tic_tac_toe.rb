require 'pry'

$game_options = {"1" => "Human v. Human", "2" => "Human v. Computer(Easy)", "3" => "Human v. Computer(Hard)"}
$grid = {"A1" => " ","A2" => " ","A3" => " ","B1" => " ","B2" => " ","B3" => " ","C1" => " ","C2" => " ","C3" => " "}
$game_mode
$turn

def greeting
  puts "Welcome to Tic Tac Toe: The all American game!"
end

def get_game_mode
  puts "What Tic Tac Toe game would you like to play? Select 1, 2 or 3"
  $game_options.each do |opt, msg|
    puts "#{opt} is #{msg}"
  end
  user_input = gets.chomp

  until $game_options.has_key?(user_input)
    puts "#{user_input} is not an option. Please select 1, 2, or 3."
    user_input = gets.chomp
  end
  puts "You've selected #{$game_options[user_input]} mode! Let's get started."

$game_mode = user_input.to_i
end

def print_rules

  if $game_mode == 1
    puts "Player 1, you're X"
    puts "Player 2, you're O"
  elsif $game_mode == 2
    puts "Human, you're X"
  else
    puts "Human, you're O"
  end
  puts "Make your selection by letter and number."
  puts "For example, A1 = top left square, C3 = bottom right."
end

def get_grid_template
   grid_template = "  1 | 2 | 3 \n"
   grid_template += "------------\n"
   grid_template += "A A1 | A2 | A3 \n"
   grid_template += "____________\n"
   grid_template += "B B1 | B2 | B3 \n"
   grid_template += "____________\n"
   grid_template += "C C1 | C2 | C3 \n"
   return grid_template

 end

 def print_played_grid
 grid_template = get_grid_template
#puts "$grid = {#$grid}"
 $grid.each do |key, value|
       grid_template[key] = value
   end

puts grid_template
 end

 def game_over?
      if gameboard_full? || horizontal_win? || vertical_win? || diagonal_win?
     return true
      end
   return false
  end

 def gameboard_full?
   unless $grid.has_value?(" ")
   return true
  end
   return false
 end

 def horizontal_win?
   if player_horizontal_win?('X') || player_horizontal_win?('O')
     return true
   else
     return false
   end
 end

 def vertical_win?
   if player_vertical_win?('X') || player_vertical_win?('O')
     return true
   else
     return false
   end
 end

 def diagonal_win?
   if player_diagonal_win?('X') || player_diagonal_win?('O')
     return true
   else
     return false
   end
 end

 def player_horizontal_win?(player)
   if $grid['A1'] == player && $grid['A2'] == player && $grid['A3'] == player
     return true
   elsif $grid['B1'] == player && $grid['B2'] == player && $grid['B3'] == player
     return true
   elsif $grid['C1'] == player && $grid['C2'] == player && $grid['C3'] == player
     return true
   end
   return false
 end

 def player_vertical_win?(player)
   if $grid['A1'] == player && $grid['B1'] == player && $grid['C1'] == player
     return true
   elsif $grid['A2'] == player && $grid['B2'] == player && $grid['C2'] == player
     return true
   elsif $grid['A3'] == player && $grid['B3'] == player && $grid['C3'] == player
     return true
   end
   return false
 end

 def player_diagonal_win?(player)
   if $grid['A1'] == player && $grid['B2'] == player && $grid['C3'] == player
     return true
   elsif $grid['C1'] == player && $grid['B2'] == player && $grid['A3'] == player
     return true
   end
   return false
 end

def player_win?(player)
  if player_horizontal_win?(player) 
    return true
  elsif player_vertical_win?(player) 
    return true
  elsif player_diagonal_win?(player)
    return true
  end
  return false
end

 def get_player_move(is_player_1)
 puts "Make your move, " + (is_player_1 ? "player 1." : "player 2.")
 player_move = gets.chomp
 until is_valid_move?(player_move) && ! is_move_already_played?(player_move)
 puts "#{player_move} is not a valid option. Try again."
 player_move = gets.chomp
 end
 return player_move
 end

 def is_valid_move?(player_move)
 if player_move == 'A1' || player_move == 'A2' || player_move == 'A3' 
 return true
elsif player_move == 'B1' || player_move == 'B2' || player_move == 'B3' 
 return true
elsif player_move == 'C1' || player_move == 'C2' || player_move == 'C3' 
 return true
 end
 return false
 end

def is_move_already_played?(player_move)
 #is this space already taken by another player?
 if $grid[player_move] == " "
 return false
 end
 return true
end

 def set_player_move(player_move, player)
 if $grid[player_move] == " "
     $grid[player_move] = player
   else
     puts "There is already a play in square #{player_move}. #{player} loses a turn."
   end

 end

def play_game_mode_1
  player_1_turn = true

  until game_over?
    print_played_grid

    player_move = get_player_move(player_1_turn)

    set_player_move(player_move, (player_1_turn ? 'X' : 'O'))

    if player_1_turn
      player_1_turn = false
    else
      player_1_turn = true
    end #end if

  end#end until

  print_played_grid

  if player_win?('X')
    puts "Player 1 wins!"
  elsif player_win?('O')
    puts "Player 2 wins!"
  elsif gameboard_full?
    puts "It's a draw."
  else
    puts "How did this happen?!"
  end
end

def play_game_mode_2
  human_turn = true

  until game_over?
    print_played_grid
    if human_turn
      player_move = get_player_move(human_turn)
      set_player_move(player_move, 'X')
    else
      player_move = generate_dumb_computer_move
      set_player_move(player_move, 'O')
    end

    if human_turn
      human_turn = false
    else
      human_turn = true
    end #end if
  end #end until

  print_played_grid

  if player_win?('X')
    puts "Human wins! (Of course)"
  elsif player_win?('O')
    puts "Computer wins! (Are you even trying, human?)"
  elsif gameboard_full?
    puts "It's a draw. (Come on, human. You can do better.)"
  else
    puts "How did this happen?!"
  end

end

def generate_dumb_computer_move
  #play the first available space
  $grid.each do |key, value|
    if value == " "
      return key
    end
  end
end

def play_game_mode_3
  computer_turn = true
  $turn = 0

  until game_over?
    if computer_turn
      player_move = generate_smart_computer_move
      set_player_move(player_move, 'X')
    else
      player_move = get_player_move(computer_turn)
      set_player_move(player_move, 'O')
    end

    if computer_turn
      computer_turn = false
    else
      computer_turn = true
    end #end if
    $turn = $turn+1
    print_played_grid
  end #end until

  if player_win?('O')
    puts "Human wins! (Improbable!)"
  elsif player_win?('X')
    puts "Computer wins! (Don't feel too bad, human.)"
  elsif gameboard_full?
    puts "It's a draw. (Good job, human.)"
  else
    puts "How did this happen?!"
  end

end

def generate_smart_computer_move
# http://en.wikipedia.org/wiki/Tic-tac-toe#Strategy
# http://upload.wikimedia.org/wikipedia/commons/d/de/Tictactoe-X.svg
  puts "turn = #{$turn}" #this is for debugging
  if $turn == 0 
    return 'A1'
  elsif $turn == 2
    if $grid['A2'] == 'O' || $grid['A3'] == 'O'
      return 'B1'
    elsif $grid['B1'] == 'O' || $grid['B2'] == 'O' || $grid['C1'] == 'O'
      return 'A2'
    elsif $grid['B3'] == 'O' 
      return 'B2'
    else
      return 'A3'
    end
  elsif $turn == 4 
    if $grid['B1'] == 'X' && $grid['C1'] == ' '
      return 'C1' #done
    elsif $grid['B1'] == 'X' && $grid['C1'] == 'O'
      return 'B2'
    elsif $grid['A2'] == 'X' && $grid['A3'] == ' '
      return 'A3' #done
    elsif $grid['A2'] == 'X' && $grid['A3'] == 'O' && $grid['B2'] == ' '
      return 'B2' 
    elsif $grid['A2'] == 'X' && $grid['A3'] == 'O' && $grid['B2'] != ' '
      return 'C1' 
    elsif $grid['B2'] == 'X' && $grid['C3'] == ' '
      return 'C3' #done 
    elsif $grid['B2'] == 'X' && $grid['C3'] == 'O'
      return 'A3' 
    elsif $grid['A3'] == 'X' && $grid['A2'] == ' '
      return 'A2' #done 
    elsif $grid['A3'] == 'X' && $grid['C2'] == 'O'
      return 'B2' 
    elsif $grid['A3'] == 'X' && $grid['C3'] == 'O'
      return 'C1'  
    else
      return '?1'
    end
  elsif $turn == 6 
    if $grid['B2'] == 'X' && $grid['C3'] == ' '
      return 'C3' #done
    elsif $grid['B2'] == 'X' && $grid['B1'] == 'X' && $grid['B3'] == ' '
      return 'B3' #done
    elsif $grid['B2'] == 'X' && $grid['B3'] == 'X' && $grid['B1'] == ' '
      return 'B1' #done
    elsif $grid['B2'] == 'X' && $grid['A2'] == 'X' && $grid['C2'] == ' '
      return 'C2' #done
    elsif $grid['B2'] == 'X' && $grid['C2'] == 'X' && $grid['A2'] == ' '
      return 'A2' #done
    elsif $grid['B2'] == 'X' && $grid['A3'] == 'X' && $grid['C1'] == ' '
      return 'C1' #done
    elsif $grid['B2'] == 'X' && $grid['C1'] == 'X' && $grid['A3'] == ' '
      return 'A3' #done
    elsif $grid['A2'] == 'X' && $grid['A3'] == ' '
      return 'A3' #done
    elsif $grid['A3'] == 'X' && $grid['A2'] == ' '
      return 'A2' #done
    elsif $grid['A3'] == 'X' && $grid['C1'] == 'X' && $grid['B2'] == ' '
      return 'B2' #done
    elsif $grid['C1'] == 'X' && $grid['B1'] == ' '
      return 'B1' #done
    elsif $grid['A2'] == 'X' && $grid['A3'] == 'O' && $grid['C1'] == ' '
      return 'C1' 
    elsif $grid['B2'] == 'O' && $grid['A3'] == 'O' && $grid['B1'] == 'O'
      return 'B3'
    else
      return '?2'
    end
  elsif $turn == 8 
    if $grid['B2'] == 'O' && $grid['A3'] == 'O' && $grid['B1'] == 'O' && $grid['B3'] == ' '
      return 'B3'
    elsif $grid['B2'] == 'O' && $grid['A3'] == 'O' && $grid['B1'] == 'O' && $grid['C2'] == ' '
      return 'C2'
    elsif $grid['B2'] == 'O' && $grid['A3'] == 'O' && $grid['B1'] == 'O' && $grid['C3'] == ' '
      return 'C3'
    else
      return '?3'
    end
  end #end if $turn == 0 
end #end def

def generate_medium_smart_computer_move
#incomplete list of possible paths:
#A1, B1, C1 - done
#A1, B1, (no C1) B2, C3 - done
#A1, B1, (no C1) B2, (no C3), B3 - done
#A1, B1, (no C1) B2, (no C3 or B3) 
#A1, B1, (no C1 or B2), A2 
#A1, (no B1) A2, A3 - done

  puts "turn = #{$turn}"
  if $turn == 0 
    return 'A1'
  elsif $turn == 2
    if $grid['B1'] == ' '
      return 'B1'
    else
      return 'A2'
    end #end if $grid['B1'] == ' '
  elsif $turn == 4
    if $grid['B1'] == 'X'
      if $grid['C1'] == ' '
        return 'C1' #done
      elsif $grid['B2'] == ' '
        return 'B2'
      else
        return 'A3'
      end #end if $grid['C1'] == ' '
    elsif $grid['A2'] == 'X' 
      if $grid['A3'] == ' '
        return 'A3'
      else
        return 'B2'
      end
    end #end if $grid['B1'] == 'X'
  elsif $turn == 6
    if $grid['B2'] == 'X'
      if $grid['C3'] == ' '
        return 'C3' #done
      elsif $grid['B3'] == ' '
        return 'C2' #done
      else
        return 'A3'
      end
    elsif $grid['A2'] == ' '
      return 'A2' #done
    else
      return 'C2'
    end
  elsif $turn == 8
    if $grid['C2'] == ' '
      return 'C2'
    elsif $grid['B3'] == ' '
      return 'B3'
    else 
      return 'C3'
    end
  end #end if $turn == 0 
end #end def

def tic_tac_toe
  greeting

  get_game_mode

  print_rules

  if $game_mode == 1
    play_game_mode_1
  elsif $game_mode == 2
    play_game_mode_2
  else
    play_game_mode_3
  end

end#end tic_tac_toe

tic_tac_toe

