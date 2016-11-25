require_relative 'tile'

class Board
  attr_reader :board_size, :num_bombs

  def initialize(board_size, num_bombs)
    @board_size, @num_bombs = board_size, num_bombs

    generate_board
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  #if reveal == true then game is over, reveal all tiles
  def render(reveal = false)
    @grid.map do |row|
      row.map do |tile|
        reveal ? tile.reveal : tile.render
      end.join("")
    end.join("\n")
  end

  def reveal
    render(true)
  end

  def won?
    @grid.flatten.all? { |tile| tile.bombed? != tile.explored? }
  end

  def lost?
    @grid.flatten.any? { |tile| tile.bombed? && tile.explored? }
  end

  private
  def generate_board
    @grid = Array.new(@board_size) do |row|
      Array.new(@board_size) do |col|
        Tile.new(self, [row, col])
      end
    end

    plant_bombs
  end

  def plant_bombs
    total_bombs = 0
    while total_bombs < @num_bombs
      rand_pos = Array.new(2) { rand(@board_size) }
      tile = self[rand_pos]

      unless tile.bombed?
        tile = self[rand_pos]
        tile.plant_bomb
        total_bombs += 1
      end
    end
  end
end
