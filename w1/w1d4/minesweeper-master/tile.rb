class Tile
  DELTAS = [[-1, -1], [-1, 0], [-1, 1], [ 0, -1],
            [ 0,  1], [ 1, -1], [ 1, 0], [ 1, 1]].freeze

  attr_reader :pos

  def initialize(board, pos)
    @board, @pos = board, pos
    @bombed, @explored, @flagged = false, false, false
  end

  #check if tile is bombed/explored/flagged
  def bombed?
    @bombed
  end

  def explored?
    @explored
  end

  def flagged?
    @flagged
  end

  #count number of bombs surrounding tile
  def adjacent_bomb_count
    neighbors.select(&:bombed?).count
  end

  #explores tile
  def explore
    return self if flagged? || explored?

    @explored = true
    #keeps exploring neighboring ones without bomb
    neighbors.each(&:explore) if !bombed? && adjacent_bomb_count == 0

    self
  end

  def inspect
    { pos: pos,
      bombed: bombed?,
      flagged: flagged?,
      explored: explored? }.inspect
  end

  def neighbors
    neighbor_coords = DELTAS.map do |(dx, dy)|
      [pos[0] + dx, pos[1] + dy]
    end.select do |row, col|
      [row, col].all? do |coord|
        coord.between?(0, @board.grid_size - 1)
      end
    end

    neighbor_coords.map { |pos| @board[pos] }
  end

  def plant_bomb
    @bombed = true
  end

  def render
    if flagged?
      "F"
    elsif explored?
      adjacent_bomb_count == 0 ? "_" : adjacent_bomb_count.to_s
    else
      "*"
    end
  end

  #when revealing all tiles
  def reveal
    if flagged?
      # "F" == correct "f" == wrong
      bombed? ? "F" : "f"
    elsif bombed?
      # if selected bomb, "x", else "b"
      explored? ? "X" : "B"
    else
      adjacent_bomb_count == 0 ? "_" : adjacent_bomb_count.to_s
    end
  end

  #toggles between flagged/unflagged
  #won't flag explored spots
  def toggle_flag
    @flagged = !@flagged unless @explored
  end
end
