class Player
  attr_accessor :name, :piece

  def initialize(name, piece)
    @name = name
    @piece = piece
  end
end


class Board
  attr_accessor :board

  def initialize(board = Array.new(7) {|x| ["-","-","-","-","-","-"]})
    @board = board
  end

  def move_valid?(turn)
    board[turn-1].any? { |x| x == "-"}
  end

  def make_move(turn, piece)
    board[turn-1][board[turn-1].index("-")] = piece
  end

  # not used now, might use for AI later
  def possible_moves
    moves = []
    board.each_with_index {|x,y| moves << [y, x.index("-")]}
    moves
  end

  def win?(input)
    check_rows?(input) || check_cols?(input) || check_diags?(input) || check_other_diags?(input)
  end

  def tie?
    board.none? {|x| x.include?("-")}
  end

  def display
    puts "\n1|2|3|4|5|6|7\n\n"
    array = board.transpose {|x| x}.reverse
    puts array[0].join("|")
    puts array[1].join("|")
    puts array[2].join("|")
    puts array[3].join("|")
    puts array[4].join("|")
    puts array[5].join("|")
    puts
  end

  private
  def check_cols?(input)
    board.each {|x| return true if x.join.include?(input * 4)}
    false
  end

  def check_rows?(input)
    board.transpose.each {|x| return true if x.join.include?(input * 4)}
    false
  end

  def check_diags?(input)
    (0..6).map{|i|board[i][i]}.join.include?(input * 4) ||
    (0..6).map{|i|board[i][i-1]}.join.include?(input * 4) ||
    (2..6).map{|i|board[i][i-2]}.join.include?(input * 4) ||
    (3..6).map{|i|board[i][i-3]}.join.include?(input * 4) ||
    (0..4).map{|i|board[i][i+1]}.join.include?(input * 4) ||
    (0..3).map{|i|board[i][i+2]}.join.include?(input * 4)
  end

  def check_other_diags?(input)
    array = board.map {|x| x.reverse}
    (0..6).map{|i|array[i][i]}.join.include?(input * 4) ||
    (0..6).map{|i|array[i][i-1]}.join.include?(input * 4) ||
    (2..6).map{|i|array[i][i-2]}.join.include?(input * 4) ||
    (3..6).map{|i|array[i][i-3]}.join.include?(input * 4) ||
    (0..4).map{|i|array[i][i+1]}.join.include?(input * 4) ||
    (0..3).map{|i|array[i][i+2]}.join.include?(input * 4)
  end
end


class Game

  def initialize
    @board = Board.new
  end

  def board
    @board
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
    @player1 = Player.new("Player 1", x_or_o[0])
    @player2 = Player.new("Player 2", x_or_o[1])
    puts "\n\nPlayer 1 is randomly assigned to #{x_or_o[0]}."
    puts "Therefore, Player 2 is assigned to #{x_or_o[1]}."
    @players = [@player2, @player1]
  end

  def turn
    puts "\n#{@players[0].name}'s turn!  Enter a column number between 1 and 7, inclusive:"
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
      until board.tie? || board.win?(@players[0].piece)
        @players.reverse!
        board.make_move(turn, @players[0].piece)
        board.display
      end
      if board.win?(@players[0].piece)
        puts "\n\nCongrats, #{@players[0].name}!!"
      else 
        puts "\n\nIt's a tie!"
      end
    end
  end
end

game = Game.new
game.play