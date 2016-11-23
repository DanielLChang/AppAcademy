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
    @board.grid.each_with_index do |row, idx1|
      string = []
      row.each_index do |idx2|
        if @cursor.cursor_pos == [idx1, idx2]
          string << @board.grid[idx1][idx2].symbol.colorize(:red)
        else
          string << @board.grid[idx1][idx2].symbol
        end
      end
      puts string.join(" ")
    end
    nil
  end

end
