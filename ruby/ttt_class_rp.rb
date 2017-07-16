require 'pry'

$grid = {"A1" => " ","A2" => " ","A3" => " ","B1" => " ","B2" => " ","B3" => " ","C1" => " ","C2" => " ","C3" => " "}
WINNER = [["A1","A2","A3"],["B1","B2","B3"],["C1","C2","C3"],["A1","B1","C1"],["A2","B2","C2"],["A3","B3","C3"],
["A1","B2","C3"],["A3","B2","C1"]]
$game_mode

def greeting
  puts "Welcome to Tic Tac Toe: The all American game!"
end

class Player
  attr_accessor :game_options
  @game_options = {"1" => "Human v. Human", "2" => "Human v. Computer(Easy)"}
binding.pry

  def self.get_game_mode
    puts "What Tic Tac Toe game would you like to play? Select 1 or 2."
    @game_options.each do |opt, msg|
      puts "#{opt} is #{msg}"
    end
    user_input = gets.chomp

    until @game_options.has_key?(user_input)
      puts "#{user_input} is not an option. Please select 1 or 2."
      user_input = gets.chomp
    end
    puts "You've selected #{@game_options[user_input]} mode! Let's get started."
    $game_mode = user_input.to_i
  end

  def get_player_move(is_player_1)
    puts "Make your move, " + (is_player_1 ? "player 1." : "player 2.")
    player_move = gets.chomp
    until is_valid_move?(player_move) && ! is_move_already_played?(player_move)
      puts "#{player_move} is not a valid option. Try again."
      player_move = gets.chomp
    end
  end

  def is_valid_move?(player_move)
    if $grid.has_key?(player_move) #got rid if 4 lines here
      return true
    end
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
      result = $grid[player_move] = player
    else
      puts "There is already a play in square #{player_move}. #{player} loses a turn."
    end
    set_winner_array(player_move,result)
  end

  def set_winner_array(player_move, result)
    WINNER.include?(player_move) do |w|
      w[player_move]= result
    end
  end
end


class Computer
  def initialize(play_mode_2)
    @play_mode_2 = play_mode_2
  end

  def play_mode_2
    @play_mode_2 = $game_mode = 2
  end

  def generate_dumb_computer_move
    #play the first available space
    $grid.each do |key, value|
      if value == " "
        return key
      end
    end
  end
end

class Game
  #attr_reader ???

  def initialize(get_player_move)  #how about global var $grid?
    @move = get_player_move
  end

  def get_game_mode
    @get_game_mode = $game_mode
  end

  def get_grid_template
    grid_template = "  1 | 2 | 3 \n"
    grid_template += "------------\n"
    grid_template += "A A1 | A2 | A3 \n"
    grid_template += "____________\n"
    grid_template += "B B1 | B2 | B3 \n"
    grid_template += "____________\n"
    grid_template += "C C1 | C2 | C3 \n"
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
    if gameboard_full? || win? #win? replaced 3 other unneccessary win fx
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

  def win? #this simple fx, lead me to delete 40 lines of code. ^_^
    WINNER.all? {|w| w.uniq.length == 1}
  end

  def print_rules #TODO: GOES WHERE???

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

  def play_game_mode_1
    player_1_turn = true

    until game_over?
      print_played_grid
      @move = get_player_move(player_1_turn)
      set_player_move(@move, (player_1_turn ? 'X' : 'O'))

      if player_1_turn
        player_1_turn = false
      else
        player_1_turn = true
      end
    end

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
end

# def tic_tac_toe
#   greeting
#   get_game_mode
#   print_rules
#     if $game_mode == 1
#       play_game_mode_1
#     else $game_mode == 2
#       play_game_mode_2
#     end
#end

#tic_tac_toe
greeting
Player.new
Game
binding.pry
