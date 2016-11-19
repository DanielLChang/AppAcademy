require_relative "tile"

class Board

  SOLVED_SOL = (1..9).to_a

  attr_reader :grid

  def self.empty_grid
    Array.new(9) do
      Array.new(9) { Tile.new(0) }
    end
  end

  def initialize(grid = self.empty_grid)
    @grid = grid
  end

  def self.from_file(filename)
    rows = File.readlines(filename).map(&:chomp)
    tiles = rows.map do |row|
      nums = row.split.map(&:to_i)
      nums.map { |num| Tile.new(num) }
    end
    self.new(tiles)
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, val)
    row, col = pos
    @grid[row][col].value = val
  end

  def render
    @grid.each_with_index { |row, idx| puts "#{idx} #{row.join(" ")}" }
  end

  def rows
    @grid
  end

  def cols
    rows.transpose
  end

  def squares
    checker = []
    9.times { |i| checker << square(i) }
    checker
  end

  def square(idx)
    tiles = []

    x = (idx / 3) * 3
    y = (idx % 3) * 3

    (x...x + 3).each do |row|
      (y...y + 3).each do |col|
        tiles << self[[row, col]]
      end
    end

    tiles
  end

  def solved?
    return false unless rows.all?    { |row| solved_set?(row) }
    return false unless cols.all?    { |col| solved_set?(col) }
    return false unless squares.all? { |square| solved_set(square) }
    true
  end

  def solved_set?(tiles)
    tiles.map(&:value).sort == SOLVED_SOL
  end

  def size
    @grid.size
  end

  def dup
    duped_grid = @grid.map do |row|
      row.map { |tile| Tile.new(tile.value) }
    end

    Board.new(duped_grid)
  end

end
