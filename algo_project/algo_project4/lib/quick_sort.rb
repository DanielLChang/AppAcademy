class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    pivot = rand(array.length)
    temp = array[0]
    array[0] = array[pivot]
    array[pivot] = temp

    left = array.select { |el| array.first > el }
    middle = array.select { |el| array.first == el }
    right = array.select { |el| array.first < el }

    sort1(left) + middle + sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length < 2

    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    pivot = partition(array, start, length, &prc)

    left = pivot - start
    right = length - (left + 1)

    sorted_left = sort2!(array, start, left, &prc)
    sorted_right = sort2!(array, pivot + 1, right, &prc)

    sorted_left + sorted_right
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    pivot_idx = start
    pivot = array[pivot_idx]

    (start + 1).upto(start + length - 1) do |idx|
      if prc.call(pivot, array[idx]) > 0
        temp = array[idx]
        array[idx] = array[pivot_idx + 1]
        array[pivot_idx + 1] = temp
        pivot_idx += 1
      end
    end

    temp = array[start]
    array[start] = array[pivot_idx]
    array[pivot_idx] = temp
    pivot_idx
  end
end
