require_relative 'tic_tac_toe'

class TicTacToeNode

  MASTER_LIST = [0, 1, 2].product([0, 1, 2])

  attr_accessor :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if board.over?
      return true if board.won? && board.winner != evaluator
    end

    if next_mover_mark == evaluator
      children.all? { |move| move.losing_node?(evaluator) }
    else
      children.any? { |move| move.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
    if board.over?
      return board.winner == evaluator
    end

    if next_mover_mark == evaluator
      children.any? { |move| }
    else
      children.all? { |move| }
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    moves = []

    if next_mover_mark == :x
      next_mover_mark = :o
    else
      next_mover_mark = :x
    end

    MASTER_LIST.each do |move|
      if board.empty?(move)
        @prev_move_pos = move
      end
      moves << TicTacToeNode.new(board.dup, next_mover_mark, prev_move_pos)
    end

    moves
  end

end
