class Player
  attr_accessor :name, :piece

  def initialize(name = nil, piece = nil)
    @name = name
    @piece = piece
  end
end