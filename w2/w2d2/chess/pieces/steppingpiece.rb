module SteppingPiece
  def moves
    valid = []
    move_diffs.each do |dx, dy|
      x, y = @pos
      new_pos = [x += dx, y += dy]
      if @board.in_bounds?(new_pos)
        if @board[new_pos].is_a?(NullPiece)
          valid << new_pos
        elsif @board[@pos].color != @board[new_pos].color
          valid << new_pos
        end
      end
    end

    valid
  end
  #
  # def move_diffs
  #
  # end
end
