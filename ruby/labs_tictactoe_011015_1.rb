@game_options = {"1" => "Human v. Human", "2" => "Human v. Computer(Easy)", "3" => "Human v. Computer(Hard)"}
@spaces = 1.upto(9).to_a
@win = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
@turns = 9

def get_board                                 # output
  grid_h =  "---+---+---\n"                   #    1 | 2 | 3
  @spaces.each_slice(3) do |row|              #   ---+---+---
    puts ' ' + row.join(' | ')                #    4 | 5 | 6
    if row != @spaces.last(3)                 #   ---+---+---
      puts grid_h                             #    7 | 8 | 9
    end
  end
end

def validation(validate,input,validation_type,player=nil)
  invalid_msg = " is not an option. Please select "
  until validate
    case validation_type
    when 'game_mode'
      puts "#{input}" + invalid_msg + "1, 2, or 3."
      input = gets.chomp
      validate = @game_options.has_key?(input)
    when 'xo'
      puts "#{input}" + invalid_msg + "'X' or 'O'."
      input = gets.chomp
      validate = input == /^[xo]$/i
    when 'game_move'
      puts "#{input}" + invalid_msg + "an available number on the board"
      input = gets.chomp.to_i
      validate = is_valid_move?(input)
    end
  end
  validation_end(validation_type,input,player)
end

def validation_end(validation_type,input,player=nil)
  case validation_type #separate into different function....
  when 'game_mode'
    puts "You've selected #{@game_options[input]} mode! Let's get started."
  when 'xo'
    @player1 = input.upcase!
    @player1 == "X" ? @player2 = "O" : @player2 = "X"
    puts "You are '#{@player1}'. Your oppenent is '#{@player2}'."
  when 'game_move'
    set_player_move(input, player)
    set_win_arr(input, player)
  end
end

def get_game_mode
  puts "Welcome to Tic Tac Toe: The all American game! \n What Tic Tac Toe game would you like to play? Select 1, 2 or 3"
  @game_options.each do |opt, msg|
    puts "#{opt} is #{msg}"
  end
  user_input = gets.chomp
  validate = @game_options.has_key?(user_input)
  validation(validate,user_input,"game_mode")
  select_xo
end

def select_xo
  puts "But first... do you want to be 'X' or 'O'?"
  user_input = gets.chomp
  validate = user_input =~ /^[xo]$/i
  validation(validate,user_input,'xo')
  puts "Select any number on the board for where you would like to go! \n"
  get_board
  get_player_move(@player1)
end

def get_player_move(player)
  player_move = gets.chomp.to_i
  validate = is_valid_move?(player_move)
  validation(validate,player_move,'game_move',player)
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
    puts "#{player} wins!"
  end
end

def gameboard_full?
  @turns == 0
end

def game_over?(player)
  player_win?(player) || gameboard_full?
  puts "Thanks for playing!"
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
  @turns.times do
  #until game_over?(player)
    @player1 = player
    player == @player1 ? @player2 : @player1
    get_player_move(player)
    get_board
    game_over?(player) if @turns == 5
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
