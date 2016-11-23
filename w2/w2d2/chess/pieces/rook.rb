require_relative 'slidingpiece'
require_relative 'piece'
class Rook < Piece
  include SlidingPiece

  def symbol
    @symbol = color == :white ? "♖" : "♜"
  end

  def move_dirs
    horizontal_dirs
  end
end
