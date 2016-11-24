def my_uniq(array)
  raise ArgumentError unless array.is_a?(Array)
  result = []
  array.each { |ele| result << ele unless result.include?(ele) }
  result
end

class Array
  def two_sum
    result = []
    0.upto(self.length - 2) do |idx1|
      (idx1 + 1).upto(self.length - 1) do |idx2|
        result << [idx1, idx2] if self[idx1] + self[idx2] == 0
      end
    end
    result
  end
end

def my_transpose(matrix)
  raise "not an array" unless matrix.is_a?(Array)
  raise ArgumentError unless matrix.first.is_a?(Array)

  result = []

  matrix.first.length.times do |idx|
    result << []
    matrix.each do |arr|
      result[idx] << arr[idx]
    end
  end

  result
end

def stock_picker(stock_prices)
  raise ArgumentError unless stock_prices.is_a?(Array)
  raise "not enough days" if stock_prices.length < 2

  best_so_far = stock_prices[0] - stock_prices[1]
  best_buy = 0
  best_sell = 1

  0.upto(stock_prices.length - 2) do |idx|
    (idx + 1).upto(stock_prices.length - 1) do |idx2|
      if stock_prices[idx] - stock_prices[idx2] < best_so_far
        best_so_far = stock_prices[idx] - stock_prices[idx2]
        best_buy = idx
        best_sell = idx2
      end
    end
  end

  [best_buy, best_sell]
end

class Towers

  attr_reader :towers

  def initialize
    @towers = [[1, 2, 3], [], []]
  end

  def valid_move?(from_pos, to_pos)
    return false if from_pos == to_pos
    return false if @towers[from_pos].empty?
    return true if @towers[to_pos].empty?
    @towers[from_pos].first < @towers[to_pos].first
  end

  def move(from_pos, to_pos)
    moving = @towers[from_pos].shift
    @towers[to_pos].unshift(moving)
  end

  def won?
    @towers[0].empty? && (@towers[1].empty? || @towers[2].empty?)
  end

end

if $PROGRAM_NAME == __FILE__
  game = Towers.new
  puts "Towers of Hanoi Game"
  until game.won?
    p game.towers
    puts "Enter a starting tower: "
    from = gets.chomp.to_i
    puts "Enter a to tower: "
    to = gets.chomp.to_i
    if game.valid_move?(from, to)
      game.move(from, to)
    else
      puts "Invalid move."
    end
  end
  p game.tower
  puts "You've won."
end
