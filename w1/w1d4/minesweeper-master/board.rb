require_relative 'tile'

class Board

  attr_accessor :grid, :size, :num_bombs

  def initialize(size, num_bombs)
    @size, @num_bombs = size, num_bombs

    @grid = Array.new(@size) do |row|
      Array.new(@size) do |col|
        Tile.new(self, [row, col])
      end
    end

    populate_grid
  end

  #bracket method
  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  #plants bombs on board
  def populate_grid
    board_bombs = 0
    while board_bombs < num_bombs
      rand_pos = [rand(@grid_size), rand(@grid_size)]

      tile = self[rand_pos]
      unless tile.bomb?
        tile.plant_bomb
        board_bombs += 1
      end
    end
  end

  #reveal_all = true at end of game
  def render(reveal_all = false)
    @grid.map do |row|
      row.map do |tile|
        reveal_all ? tile.reveal : tile.render
      end.join("")
    end.join("\n")
  end

  #reveal_all
  def reveal
    render(true)
  end

  def lost?
    @grid.flatten.any? { |tile| tile.bomb? && tile.reveal? }
  end

  def won?
    @grid.flatten.all? { |tile| tile.bombed? != tile.reveal? }
  end

end
