require 'singleton'
require_relative 'piece'

class NullPiece < Piece
  include Singleton

  attr_reader :color, :symbol

  def initialize
    @color = nil
    @symbol = "_"
  end

  def moves
    []
  end
end
