require 'colorize'

class Tile

  attr_reader :reader

  def initialize(value)
    @value = value
    @given = value == 0 ? false : true
  end

  def

  def to_s
    value == 0 ? " " : value.colorize(color)
  end

  def color
    @given ? :blue : :red
  end

  def value=(val)
    @given ? (puts "already given") : (@value = val)
  end
end
