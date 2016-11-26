class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    arr_dup = self.dup
    hash_int = arr_dup.shift.hash
    arr_dup.each_with_index do |el, index|
      hash_int ^= (el + index).hash
    end

    hash_int
  end
end

class String
  def hash
    chars_arr = chars.map(&:ord)
    chars_arr.each_with_index.inject(0) do |hash_int, (ord, index)|
      hash_int ^ (ord + index).hash
    end
    # chars.inject { |hash_int, char| hash_int ^ char.ord.hash }
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash_int = 0
    self.each do |key, value|
      hash_int ^= (key.hash + value.hash)
    end
    hash_int
  end
end
