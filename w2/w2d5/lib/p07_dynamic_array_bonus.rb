class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  include Enumerable
  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    return nil unless i.abs < @store.length
    if i < 0
      @store[@count + i]
    else
      @store[i]
    end
  end

  def []=(i, val)
    prev_el = self[i]

    if i < 0
      @store[@count + i] = val
      @count += 1 unless prev_el
    elsif i > @count
      until @count == i
        push(nil)
      end
      push(val)
    else
      @store[i] = val
      @count += 1 unless prev_el
    end
  end

  def capacity
    @store.length
  end

  def include?(val)
    each do |el|
      return true if el == val
    end
    false
  end

  def push(val)
    resize! if count == capacity
    @store[@count] = val
    @count += 1
  end

  def unshift(val)
    resize! if count == capacity

    i = @count - 1
    while i >= 0
      @store[i + 1] = @store[i]
      i -= 1
    end

    @store[0] = val
    @count += 1
  end

  def pop
    return nil if @count < 1
    el = @store[@count - 1]
    @store[@count - 1] = nil
    @count -= 1
    el
  end

  def shift
    return nil if @count < 1
    el = @store[0]

    i = 0
    while i < @count - 1
      @store[i] = @store[i + 1]
      i += 1
    end
    pop

    el
  end

  def first
    @store[0]
  end

  def last
    @store[@count - 1]
  end

  def each(&prc)
    0.upto(@count - 1) { |i| prc.call(@store[i]) }
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    return false unless count == other.count
    0.upto(count - 1) do |i|
      return false unless self[i] == other[i]
    end
    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    elements = StaticArray.new(capacity * 2)
    (0...capacity).each do |i|
      elements[i] = self[i]
    end

    @store = elements
  end
end
