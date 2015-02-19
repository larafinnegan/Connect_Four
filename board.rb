class Board
  attr_accessor :board

  def initialize(board = Array.new(7) {|x| ["-","-","-","-","-","-"]})
    @board = board
  end

  def move_valid?(turn)
    board[turn-1].any? {|x| x == "-"}
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
    puts (1..7).to_a.join("|")
    (board.size-1).times {|x| puts board.transpose.reverse[x].join("|")}
  end

  private
  def check_cols?(input)
    board.any? {|x| x.join.include?(input * 4)}
  end

  def check_rows?(input)
    board.transpose.any? {|x| x.join.include?(input * 4)}
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