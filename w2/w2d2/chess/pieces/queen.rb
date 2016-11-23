require_relative 'slidingpiece'
require_relative 'piece'

class Queen < Piece
  include SlidingPiece

  def symbol
    @symbol = color == :white ? "♕" : "♛"
  end

  def move_dirs
    horizontal_dirs + diagonal_dirs
  end

end
