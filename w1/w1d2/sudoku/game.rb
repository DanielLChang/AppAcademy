require_relative "board"

class Game

  attr_reader :board

  def self.from_file(filename)
    board = Board.from_file(filename)
    self.new(board)
  end

  def initialize(board)
    @board = board
  end

  def get_pos
    pos = nil
    until pos && valid_pos?(pos)
      p "enter pos (x,y) >"
      pos = parse_pos(gets.chomp)
    end
    pos
  end

  def parse_pos(string)
    string.split(",").map(&:to_i)
  end

  def valid_pos?(pos)
    return false unless pos.is_a?(Array)
    return false unless pos.length == 2
    return false unless pos.all? do |guess|
      guess >= 0 && guess < @board.size - 1
    end
    true
  end

  def get_val
    val = nil
    until val && valid_val?(val)
      p "enter val 1-9 (0 to clear) > "
      val = parse_val(gets.chomp)
    end
    val
  end

  def parse_val(string)
    Integer(string)
  end

  def valid_val?(val)
    val.is_a?(Integer) && (val >= 0 && val < 9)
  end

  def play_turn
    @board.render
    @board[get_pos] = get_val
  end

  def run
    play_turn until solved?
    @board.render
    puts "you win"
  end

  def solved?
    @board.solved?
  end

end
