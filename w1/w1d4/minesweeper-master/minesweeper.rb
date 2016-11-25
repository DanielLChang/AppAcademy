require 'byebug'
require 'yaml'
require_relative 'board'

class MinesweeperGame
  LAYOUTS = {
    small: { board_size: 9, num_bombs: 10 },
    medium: { board_size: 16, num_bombs: 40 },
    large: { board_size: 32, num_bombs: 99 }.freeze
  }.freeze

  def initialize(size)
    layout = LAYOUTS[size]
    @board = Board.new(layout[:board_size], layout[:num_bombs])
  end

  def play
    until @board.won? || @board.lost?
      puts @board.render

      move, pos = get_move
      perform_move(move, pos)
    end

    if @board.won?
      puts "You win!"
    elsif @board.lost?
      puts "you hit a bomb"
      puts @board.reveal
    end
  end

  private
  def get_move
    puts "input move (f, e, s)"
    action_type, row, col = gets.chomp.split(",")

    [action_type, [row.to_i, col.to_i]]
  end

  def perform_move(action_type, pos)
    tile = @board[pos]
    # debugger

    case action_type
    when "f"
      tile.toggle_flag
    when "e"
      tile.explore
    when "s"
      # won't quit on save, just hit ctr-c to do that.
      save
    end
  end

  def save
    puts "Enter filename to save at:"
    filename = gets.chomp

    File.write(filename, YAML.dump(self))
  end
end

if $PROGRAM_NAME == __FILE__
  case ARGV.count
  when 0
    MinesweeperGame.new(:small).play
  when 1
    YAML.load_file(ARGV.shift).play
  end
end
