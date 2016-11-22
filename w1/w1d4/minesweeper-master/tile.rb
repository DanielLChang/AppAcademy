require 'colorize'

class Tile

  DELTAS = [[-1, 1], [-1, 0], [-1, -1], [0, -1],
            [1, -1], [1, 0], [1, 1], [1, -1]].freeze

  attr_accessor :board, :pos, :bomb, :looked_at, :flag

  def initialize(board, pos)
    @board = board
    @pos = pos
    @bomb, @looked_at, @flag = false, false, false
  end

  #is tile revealed?
  def bomb?
    @bomb
  end

  #is tile looked_at?
  def looked_at?
    @looked_at
  end

  #is tile flagged?
  def flag?
    @flag
  end

  #plants bomb
  def plant_bomb
    @bomb = true
  end

  def toggle_flag
    @flagged = !@flagged unless @looked_at
  end

  def explore
    # don't explore a location user thinks is bombed.
    return self if flagged?

    # don't revisit previously explored tiles
    return self if explored?

    @explored = true
    if !bombed? && adjacent_bomb_count == 0
      neighbors.each { |adj_tile| adj_tile.explore }
    end

    self
  end

  #returns array of neighboring tiles
  def neighbors
    neighbor_pos = DELTAS.map do |(dx, dy)|
      [pos[0] + dx, pos[1] + dy]
    end
    #selects coords in board range
    neighbor_pos.select do |row, col|
      [row, col].all? { |pos| pos.between?(0, @board.length - 1) }
    end
    #maps with position on board
    neighbor_pos.map { |pos| @board[pos] }
  end

  #returns count of neighoring tiles that have bomb
  def adjacent_bomb_count
    neighbors.select(&:bomb?).count
  end

  def render
    if flag?
      "F"
    elsif looked_at?
      adjacent_bomb_count == 0 ? "_" : adjacent_bomb_count.to_s
    else
      "*"
    end
  end

  def reveal
    if flag?
      bomb? ? "F" : "f"
    elsif bomb?
      looked_at? ? "X" : "B"
    else
      adjacent_bomb_count == 0 ? "_" : adjacent_bomb_count.to_s
    end
  end

end
