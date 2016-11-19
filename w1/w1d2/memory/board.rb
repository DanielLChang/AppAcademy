require_relative "card"

class Board

  HEIGHT = 4
  WIDTH  = 5

  attr_accessor :grid, :deck

  def initialize
    @grid = Array.new(HEIGHT) { Array.new(WIDTH) }
    @deck = Array.new(HEIGHT * WIDTH / 2) do |i|
      [Card.new(i), Card.new(i)]
    end
    deck.flatten!


  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    self.grid[x][y] = value
  end


  def populate
    deck.shuffle!
    grid.each_index do |row|
      grid[row].each_index do |col|
        grid[row][col] = deck.shift
      end
    end

    grid
  end

  def render
    grid.each do |row|
      row.each do |card|
        print card.to_s
      end
      puts ""
    end
  end

  def won?
    grid.all? do |row|
      row.all?(&:faceup)
    end
  end

  def reveal(guessed_pos)
    row, col = guessed_pos
    card = grid[row][col]

    unless card.faceup
      card.reveal
      card
    end
  end

end
