require 'pry'
require 'set'

words = ['angus']

#guesses = ['x', 'i']
#comput_word = "marxist"
#player_word = "   xi  "

# for each letter in comput_word
#   if letter is in guesses
#     print letter
#   else
#     print space, or underscore, or asterisk, or something but don't show the letter

def finished? (turns, guesses, answer)
  turns.zero? || complete_word?(guesses, answer)
end

def greeting
  puts "Welcome to Hangman. You know what to do!"
end

def complete_word? (guesses, answer)
  answer.chars.all? { |l| guesses.include?(l) }
end

def game_over (turns,guesses,answer)
  if complete_word?(guesses,answer)
    puts "\nYou win!"
  else
    puts "\nYou lose. #{answer} is the answer"
  end
end

def prompt_player(turns)
  puts ' '
  puts "What letter would you like to guess? You have #{turns} turns left."
  gets.chomp.downcase
end

def display_partial_word(guesses,answer)
  #binding.pry
  answer.each_char do |c|
    if guesses.include?(c)
      print c
    else
      print '_'
    end
  end
end

def hangman(words)
  turn_count = ARGV.empty? ? 6 : ARGV[0].to_i
  guessed = Set.new
  answer = words.sample(1)[0] # words[rand(words.length)]
  greeting
  until finished?(turn_count, guessed, answer) #if finished = false run below code
    guess = prompt_player(turn_count)
    guessed.add(guess)
    # binding.pry
    display_partial_word(guessed,answer)
    unless answer.include?(guess)
      turn_count -= 1
    end
  end
  game_over(turn_count,guessed,answer) # TODO: Do I need an argument?
end

hangman(words)
#prompt_player(turns)