require 'singleton'

module SlidingPiece

  HORIZONTAL_MOVES = [[-1, 0], [1, 0], [0, -1], [0, 1]].freeze
  DIAGONAL_MOVES = [[-1, -1], [1, 1], [-1, 1], [1, -1]].freeze

  def moves

  end

  # def move_dirs
  #   horizontal_dirs
  #   diagonal_dirs
  # end

  def horizontal_dirs(dx, dy)
    result = []
    HORIZONTAL_MOVES.each do |move|
      x, y = move
      new_x, new_y = (x + dx), (y + dy)
      sub_result = []
      while (new_x >= 0 && new_x <= 7) && (new_y >= 0 && new_y <= 7)
        sub_result << [new_x, new_y]
        new_x += x
        new_y += y
      end
      result << sub_result
    end
    result
  end

  def diagonal_dirs(dx, dy)
    result = []
    DIAGONAL_MOVES.each do |move|
      x, y = move
      new_x, new_y = (x + dx), (y + dy)
      while (new_x >= 0 && new_x <= 7) && (new_y >= 0 && new_y <= 7)
        result << [new_x, new_y]
        new_x += x
        new_y += y
      end
    end
    result
  end

  def grow_hor_dir(dx, dy)
    movesets = []
    horizontal_dirs(dx, dy).each do |direction|
      direction.each do |moveset|
        movesets << moveset if board.grid.empty?
      end
    end
    movesets
  end

  def grow_dia_dir(dx, dy)
    movesets = []
    diagonal_dirs(dx, dy).each do |direction|
      direction.each do |moveset|
        movesets << moveset if board.grid.empty?
      end
    end
    movesets
  end

end

module SteppingPiece
  def moves

  end
end

class Piece
  attr_reader :color, :board

  def initialize(color)
    @color = color
    # @board = board
  end

  def to_s()
    "#{color}"
  end

  def empty?()
    @color.nil?
  end

  def symbol()
  end

  def valid_moves()
  end

  def move_into_check(to_pos)
  end

end

class NullPiece < Piece
  # include Singleton

  attr_reader :color, :symbol

  def initialize
    @color = nil
    @symbol = "_"
  end
end

class Pawn < Piece
end

class Bishop < Piece
  include SlidingPiece
end

class Queen < Piece
  include SlidingPiece
end

class Rook < Piece
  include SlidingPiece
end

class King < Piece
  include SteppingPiece
end

class Knight < Piece
  include SteppingPiece
end
