require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    #keys
    @map = HashMap.new
    #values
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      update_link!(@map.get(key))
    else
      eject! if count == @max
      calc!(key)
    end

    @map.get(key).val
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    val = @prc.call(key)
    @store.append(key, val)
    @map.set(key, @store.last)
  end

  def update_link!(link)
    link.remove
    @store.append(link.key, link.val)
  end

  def eject!
    @map.delete(@store.first.key)
    @store.first.remove
  end
end
