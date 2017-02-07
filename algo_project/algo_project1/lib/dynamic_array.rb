require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @capacity = 8
    @length = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    check_index(index)
    @store[index] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" unless @length > 0

    @length -= 1
    @store[@length]
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length == @capacity

    @length += 1
    @store[@length - 1] = val
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" unless @length > 0
    return_val = @store[0]
    @length -= 1
    @length.times do |idx|
      @store[idx] = @store[idx + 1]
    end
    return_val
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length == @capacity

    @length += 1
    @length.downto(1) do |idx|
      @store[idx] = @store[idx - 1]
    end
    @store[0] = val
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    unless (index >= 0) && (index < @length)
      raise "index out of bounds"
    end
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    new_capacity = @capacity * 2
    new_store = StaticArray.new(new_capacity)

    @length.times do |idx|
      new_store[idx] = self[idx]
    end

    @capacity = new_capacity
    @store = new_store
  end
end
