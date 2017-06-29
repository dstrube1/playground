require_relative "bowling_game"

while true
  puts "Enter your string of frame scores:"
  scores = gets.chomp

  game = BowlingGame.new(scores)

  puts "Score:" + game.total_score.to_s
end