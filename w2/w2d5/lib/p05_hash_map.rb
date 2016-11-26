require_relative 'p02_hashing'
require_relative 'p04_linked_list'
require 'byebug'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    if include?(key)
      bucket(key).update(key, val)
    else
      resize! if count + 1 == num_buckets
      bucket(key).append(key, val)
      @count += 1
    end
  end

  def get(key)
    bucket(key).each do |link|
      return link.val if link.key == key
    end
  end

  def delete(key)
    if include?(key)
      bucket(key).remove(key)
      @count -= 1
    end
  end

  def each(&prc)
    @store.each do |linked_list|
      linked_list.each do |link|
        prc.call(link.key, link.val)
      end
    end
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k} => #{v}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    pairs = []
    each { |key, val| pairs << [key, val] }
    initialize(num_buckets * 2)
    pairs.each { |pair| set(pair[0], pair[1]) }
  end

  def bucket(key)
    @store[key.hash % num_buckets]
  end
end
