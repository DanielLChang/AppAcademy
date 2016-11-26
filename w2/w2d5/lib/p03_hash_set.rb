require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
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
    @store[num.hash % num_buckets]
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
