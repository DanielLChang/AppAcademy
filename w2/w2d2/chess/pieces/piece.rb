require 'colorize'

class Piece
  attr_accessor :color, :board, :pos

  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
  end

  def to_s
    symbol
  end

  def empty?()
    @color.nil?
  end

  def dup_board
    @board.dup
  end

  def valid_moves
    all_moves = self.moves
    all_moves.reject { |move| move_into_check?(move) }
  end

  def move_into_check?(end_pos)
    new_board = @board.dup
    new_board.move_piece(pos, end_pos)
    new_board.in_check?(@color)
  end

end
