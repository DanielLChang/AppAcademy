require 'byebug'
require_relative 'pieces'

class Board
  COLORS = [:black, :white].freeze

  attr_accessor :grid

  def initialize(grid = nil)
    if grid.nil?
      make_starting_grid
    else
      @grid = grid
    end
  end


  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, val)
    x, y = pos
    @grid[x][y] = val
  end

  def dup
    dup_board = @grid.map { |row| row.dup }
    Board.new(dup_board)
  end

  def move_piece(from_pos, to_pos)
    x, y = from_pos
    a, b = to_pos
    #debugger
    if @grid[x][y].moves.include?(to_pos)
      @grid[a][b] = @grid[x][y]
      @grid[a][b].pos = to_pos
      @grid[x][y] = NullPiece.instance
    end
  end

  def move_piece!(from_pos, to_pos)

  end

  def in_check?(color)
    king_pos = find_king(color)

    (0..7).each do |idx1|
      (0..7).each do |idx2|
        current_piece = @grid[idx1][idx2]
        if current_piece.color != color
          return true if current_piece.moves.include?(king_pos)
        end
      end
    end
    false
  end

  def checkmate?(color)
    if in_check?(color)
      return true unless valid_moves?
    end
  end

  def in_bounds?(pos)
    x, y = pos
    return true if x.between?(0, 7) && y.between?(0, 7)
    false
  end

  def make_starting_grid
    @grid = Array.new(8) { Array.new(8) }
    COLORS.each do |color|
      populate_pawns(color)
      populate_back
    end

    (2..5).each do |row|
      (0..7).each do |col|
        @grid[row][col] = NullPiece.instance
      end
    end
  end

  def populate_pawns(color)
    row = color == :white ? 6 : 1
    (0..7).each do |col|
      @grid[row][col] = Pawn.new(color, self, [row, col])
    end
  end

  def populate_back
    back_pieces_black = [
      Rook.new(:black, self, [0, 0]),
      Knight.new(:black, self, [0, 1]),
      Bishop.new(:black, self, [0, 2]),
      Queen.new(:black, self, [0, 3]),
      King.new(:black, self, [0, 4]),
      Bishop.new(:black, self, [0, 5]),
      Knight.new(:black, self, [0, 6]),
      Rook.new(:black, self, [0, 7]),
    ]

    back_pieces_white = [
      Rook.new(:white, self, [7, 0]),
      Knight.new(:white, self, [7, 1]),
      Bishop.new(:white, self, [7, 2]),
      Queen.new(:white, self, [7, 3]),
      King.new(:white, self, [7, 4]),
      Bishop.new(:white, self, [7, 5]),
      Knight.new(:white, self, [7, 6]),
      Rook.new(:white, self, [7, 7]),
    ]

    back_pieces_black.each_with_index do |piece, index|
      @grid[0][index] = piece
    end

    back_pieces_white.each_with_index do |piece, index|
      @grid[7][index] = piece
    end
  end

  def find_king(color)
    (0..7).each do |idx1|
      (0..7).each do |idx2|
        current_piece = @grid[idx1][idx2]
        if current_piece.is_a?(King) && current_piece.color == color
          return current_piece.pos
        end
      end
    end
    nil
  end
end

# b = Board.new
# p b[0,0]
# p b[0,0] = 3
# p b[0,0]
