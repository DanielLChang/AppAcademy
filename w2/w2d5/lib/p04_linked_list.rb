class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @prev.next = @next
    @next.prev = @prev
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    return @head.next unless empty?
    nil
  end

  def last
    return @tail.prev unless empty?
    nil
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    each do |link|
      return link.val if link.key == key
    end
  end

  def include?(key)
    each do |link|
      return true if link.key == key
    end
    false
  end

  def append(key, val)
    unless include?(key)
      new_link = Link.new(key, val)
      @tail.prev.next = new_link
      new_link.next = @tail
      new_link.prev = @tail.prev
      @tail.prev = new_link
    end
    new_link
  end

  def update(key, val)
    each do |link|
      link.val = val if link.key == key
    end
  end

  def remove(key)
    each do |link|
      link.remove if link.key == key
    end
  end

  def each(&prc)
    curr_link = @head.next
    until curr_link == @tail
      prc.call(curr_link)
      curr_link = curr_link.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
