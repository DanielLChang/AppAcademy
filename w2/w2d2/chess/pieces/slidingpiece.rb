module SlidingPiece

  HORIZONTAL_MOVES = [[-1, 0], [1, 0], [0, -1], [0, 1]]
  DIAGONAL_MOVES = [[-1, -1], [1, 1], [-1, 1], [1, -1]]

  def moves
    valid = []
    move_dirs.each do |dx, dy|
      valid += grow_unblocked_moves_in_dir(dx, dy)
    end
    valid
  end

  # def move_dirs
  #
  # end

  def horizontal_dirs
    HORIZONTAL_MOVES
  end

  def diagonal_dirs
    DIAGONAL_MOVES
  end

  #assuming has board, pos
  def grow_unblocked_moves_in_dir(dx, dy)
    result = []

    x, y = @pos
    loop do
      new_pos = [x += dx, y += dy]
      break unless @board.in_bounds?(new_pos)

      if @board[new_pos].is_a?(NullPiece)
        result << new_pos
      elsif @board[@pos].color != @board[new_pos].color
        result << new_pos
        break
      else
        break
      end
    end

    result
  end

end
