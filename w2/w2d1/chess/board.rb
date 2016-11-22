require 'byebug'
require_relative 'piece'

class Board
  COLORS = [:black, :white].freeze

  attr_accessor :grid

  def initialize
    # debugger
    make_starting_grid
  end


  def [](x, y)
    @grid[x][y]
  end

  def []=(x, y, val)
    #x, y = pos
    @grid[x][y] = val
  end

  # def dup()
  #
  # end

  def move_piece(from_pos, to_pos)
    x, y = from_pos
    a, b = to_pos
    # begin
    #   @grid[from_pos].is_a?(NullPiece)
    # rescue
      # raise "No piece at from_pos"
      # retry
    # end
    @grid[a][b] = @grid[x][y]
    @grid[x][y] = NullPiece.new
  end

  # def move_piece!(from_pos, to_pos)
  #
  # end
  #
  # def checkmate?
  #
  # end

  def in_bounds?(pos)
    x, y = pos
    return true if (x >= 0 && x <= 7) && (y >= 0 && y <= 7)
    false
  end

  def make_starting_grid
    @grid = Array.new(8) { Array.new(8) }
    COLORS.each do |color|
      populate_pawns(color)
      populate_back(color)
    end

    (2..5).each do |row|
      (0..7).each do |col|
        @grid[row][col] = NullPiece.new
      end
    end
  end

  def populate_pawns(color)
    case color
    when :white
      (0..7).each do |col|
        @grid[6][col] = Piece.new(color)
      end
    when :black
      (0..7).each do |col|
        @grid[1][col] = Piece.new(color)
      end
    end
  end

  def populate_back(color)
    case color
    when :white
      (0..7).each do |col|
        @grid[7][col] = Piece.new(color)
      end
    when :black
      (0..7).each do |col|
        @grid[0][col] = Piece.new(color)
      end
    end
  end

  def find_king(color)
  end
end

# b = Board.new
# p b[0,0]
# p b[0,0] = 3
# p b[0,0]
