require_relative 'piece'

class Pawn < Piece

  def symbol
    @symbol = color == :white ? "♙" : "♟"
  end

  def moves
    valid = []

    valid + forward_steps + side_attacks
  end

  def at_start_row?
    @color == :white ? @pos[0] == 6 : @pos[0] == 1
  end

  def forward_dir
    @color == :white ? -1 : 1
  end

  def forward_steps
    result = []

    return result unless @board[[pos[0] + forward_dir, pos[1]]].is_a?(NullPiece)
    result << [pos[0] + forward_dir, pos[1]]
    if at_start_row?
      dir = 2 * forward_dir
      return result unless @board[[pos[0] + dir, pos[1]]].is_a?(NullPiece)
      result << [pos[0] + dir, pos[1]]
    end

    result
  end


  def side_attacks
    row_idx = @color == :white ? -1 : 1
    possible_pos = [[pos[0] + row_idx, pos[1] + 1], [pos[0] + row_idx, pos[1] + -1]]
    possible_pos.reject do |pos|
      @board[pos].color == @color && @board[pos].is_a?(NullPiece)
    end
  end

end
