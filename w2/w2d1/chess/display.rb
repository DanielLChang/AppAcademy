require 'byebug'
require 'colorize'
require_relative 'board'
require_relative 'cursor'

class Display

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def render
    @board.board.each_with_index do |row, idx1|
      string = []
      row.each_index do |idx2|
        if @cursor.cursor_pos == [idx1, idx2]
          string << @board.grid[idx1][idx2].color.to_s.colorize(:red)
        else
          string << @board.grid[idx1][idx2].color
        end
      end
      puts string.join(" ")
    end
  end

  def play
    render
    input = @cursor.get_input
    until input == :ctrl_c
      render
      input = @cursor.get_input
    end
  end

end
