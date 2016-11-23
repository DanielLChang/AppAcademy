require_relative 'slidingpiece'
require_relative 'piece'

class Bishop < Piece
  include SlidingPiece

  def symbol
    @symbol = color == :white ? "♗" : "♝"
  end

  def move_dirs
    diagonal_dirs
  end
end
