require_relative 'steppingpiece'
require_relative 'piece'

class King < Piece
  include SteppingPiece

  def symbol
    @symbol = color == :white ? "♔" : "♚"
  end

  def move_diffs
    [[-1, 0], [1, 0], [0, -1], [0, 1],
     [-1, -1], [1, 1], [-1, 1], [1, -1]]
  end
end
