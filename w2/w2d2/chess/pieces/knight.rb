require_relative 'steppingpiece'
require_relative 'piece'

class Knight < Piece
  include SteppingPiece

  def symbol
    @symbol = color == :white ? "♘" : "♞"
  end


  def move_diffs
    [[2, 1], [-2, 1], [-2, -1], [2, -1],
     [1, 2], [1, -2], [-1, -2], [-1, 2]]
  end


end
