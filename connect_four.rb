require_relative './board'
require_relative './player'

class Game
  attr_accessor :board, :players

  def initialize(board = Board.new, players = [])
    @board = board
    @players = players
  end

#only allows mode 1 for now.  No AI yet.
def game_mode
  puts "\nDo you want to play against another person or against the computer?"
  puts "\nEnter 1 to play against another person."
  puts "Enter 2 to play against the computer."
  choice = gets.chomp
  until choice == "1" || choice == "2"
    puts "Please enter 1 or 2:"
    choice = gets.chomp
  end
  choice
end

def create_players #can modify by passing mode parameter
  x_or_o = ["X","O"].shuffle
  players << Player.new("Player 1", x_or_o[0])
  players << Player.new("Player 2", x_or_o[1])
  puts "\n\nPlayer 1 is randomly assigned to #{x_or_o[0]}."
  puts "Therefore, Player 2 is assigned to #{x_or_o[1]}.\n\n"
end

def turn
  puts "\n#{@players[1].name}'s turn!  Enter a column number between 1 and 7, inclusive:"
  turn = gets.chomp
  until input_valid?(turn) && validate_move?(turn.to_i)
    if !input_valid?(turn)
      puts "Invalid input.  Enter a number between 1 and 7: "
    else
      puts "That column is full.  Please try another: " unless validate_move?(turn.to_i)
    end
    turn = gets.chomp
  end
  turn = turn.to_i
end

def input_valid?(turn)
  ("1".."7").to_a.include?(turn)
end

def validate_move?(turn)
  board.move_valid?(turn)
end

def play
  if game_mode == "1"
    create_players
    board.display
    until board.tie? || board.win?(players[0].piece)
      players.reverse!
      board.make_move(turn, players[0].piece)
      board.display
    end
    if board.win?(players[0].piece)
      puts "\n\nCongrats, #{players[0].name}!!"
    else 
      puts "\n\nIt's a tie!"
    end
  end
end
end

game = Game.new
game.play