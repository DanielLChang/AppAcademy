class MaxIntSet
  def initialize(max)
    @store = Array.new(max) { false }
  end

  def insert(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num] = true unless @store[num]
  end

  def remove(num)
    @store[num] = false if @store[num]
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num.between?(0, @store.length - 1)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num unless include?(num)
  end

  def remove(num)
    self[num].delete(num) if include?(num)
  end

  def include?(num)
    self[num].any? { |el| el == num }
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless include?(num)
      resize! if count + 1 == num_buckets
      self[num] << num
      @count += 1
    end
  end

  def remove(num)
    self[num].delete(num) if include?(num)
  end

  def include?(num)
    self[num].any? { |el| el == num }
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    curr_el = []
    num_buckets.times { |bucket| curr_el.concat(self[bucket]) }
    initialize(num_buckets * 2)
    curr_el.each { |el| insert(el) }
  end
end
