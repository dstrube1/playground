@game_options = {"1" => "Human v. Human", "2" => "Human v. Computer(Easy)", "3" => "Human v. Computer(Hard)"}
@spaces = 1.upto(9).to_a
@win = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
@turns = 9

def validation(validate,input)
  until validate
    puts "#{input} is not an option. Please select 1, 2, or 3."
    input = gets.chomp
    validate = @game_options.has_key?(input) ###1
  end
end

def get_board                                 # output
  grid_h =  "---+---+---\n"                   #    1 | 2 | 3
  @spaces.each_slice(3) do |row|              #   ---+---+---
    puts ' ' + row.join(' | ')                #    4 | 5 | 6
    if row != @spaces.last(3)                 #   ---+---+---
      puts grid_h                             #    7 | 8 | 9
    end
  end
end

def get_game_mode
  puts "Welcome to Tic Tac Toe: The all American game! \n What Tic Tac Toe game would you like to play? Select 1, 2 or 3"
  @game_options.each do |opt, msg|
    puts "#{opt} is #{msg}"
  end
  user_input = gets.chomp
  validation(@game_options.has_key?(user_input),user_input) ###3
  # until @game_options.has_key?(user_input)
  #   puts "#{user_input} is not an option. Please select 1, 2, or 3."
  #   user_input = gets.chomp
  # end
  puts "You've selected #{@game_options[user_input]} mode! To play, select any number for where you would like your piece to go on the board. \n Let's begin!\n"
  get_board
  select_xo
end

def select_xo
  puts "But first... do you want to be 'X' or 'O'?"
  user_input = gets.chomp
  until user_input =~ /^[xo]$/i
    puts "#{user_input} is not an option. Please select 'X' or 'O'."
    user_input = gets.chomp
  end
  @player1 = user_input.upcase
  @player1 == "X" ? @player2 = "O" : @player2 = "X"
  puts "You are '#{@player1}'. Your oppenent is '#{@player2}'."
  get_player_move(@player1)
end

def get_player_move(player)
###4
  puts "Player #{player}, make your move"
  player_move = gets.chomp.to_i
  until is_valid_move?(player_move) ###5
    puts "#{player_move} is not a valid option. Try again."
    player_move = gets.chomp.to_i
  end
  set_player_move(player_move, player)
  set_win_arr(player_move, player)
end

  def is_valid_move?(player_move)
    @spaces.each do |s|
      @spaces[s] == player_move
    end
  end

  def set_player_move(player_move, player)
    @spaces[player_move - 1] = player
  end

  def set_win_arr(player_move, player)
    @win.each do |combo|
      combo.each do |space|
        if space == player_move
          combo[combo.index(space)] = player
        end
      end
    end
  end

def player_win?(player)
  @win.each do |combo|
    combo.uniq.length == 1
  end ###2
end

def gameboard_full?
  @turns == 0
end

def game_over?
  player_win? || gameboard_full?
end

# def play_game_mode_1
#   player_1_turn = true
#   until game_over?
#     get_board
#     player_move = get_player_move(player_1_turn)
#     if player_1_turn ? false : true end
#   end
#   get_board
#   if player_win?(player)
#     puts "#{player} wins!"
#   else gameboard_full?
#     puts "It's a draw."
#   end
# end

# def play_game_mode_2
#   human_turn = true
#
#   until game_over?
#     get_board
#     if human_turn
#       player_move = get_player_move(human_turn)
#     else
#       player_move = generate_dumb_computer_move
#       set_player_move(player_move, 'O')
#     end
#
#     if human_turn
#       human_turn = false
#     else
#       human_turn = true
#     end #end if
#   end #end until
#
#   get_board
#
#   if player_win?('X')
#     puts "Human wins! (Of course)"
#   elsif player_win?('O')
#     puts "Computer wins! (Are you even trying, human?)"
#   elsif gameboard_full?
#     puts "It's a draw. (Come on, human. You can do better.)"
#   else
#     puts "How did this happen?!"
#   end
#
# end

#   def generate_dumb_computer_move
#     #play the first available space
#     @spaces.each do |key, value|
#       if value == " "
#         return key
#       end
#     end
#   end
# end

def tic_tac_toe
  get_game_mode
  until game_over?
    get_player_move(player)
    player == @player1 ? @player2 : @player1
    get_board
    game_over? if @turns == 5
    @turns =- 1
  end
#   get_game_mode
#   if @game_mode == 1
#     play_game_mode_1
#   else
#     play_game_mode_2
#   end
end

tic_tac_toe
