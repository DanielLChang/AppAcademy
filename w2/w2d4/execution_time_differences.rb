require 'benchmark'

# # Phase 1
# def my_min(arr)
#   min = arr.first
#   0.upto(arr.length - 2) do |index1|
#     (index1 + 1).upto(arr.length - 1) do |index2|
#       min = arr[index1] if arr[index1] < min
#     end
#   end
#   min
# end

# # Phase 2
# def my_min(arr)
#   min = arr.first
#   0.upto(arr.length - 2) do |index1|
#     min = arr[index1] if arr[index1] < min
#   end
#   min
# end

# list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
# p my_min(list)

## Largest contiguous Sub-sum
def subsets(arr)
  result = []
  0.upto(arr.length - 1) do |idx1|
    idx1.upto(arr.length - 1) do |idx2|
      result << arr[idx1..idx2]
    end
  end
  result
end

list = [5, 3, -7]

# # Phase 1
# def largest_contiguous_subsum(list)
#   arr_sums = []
#
#   subsets(list).each do |sub|
#     arr_sums << sub.inject(&:+)
#   end
#
#   arr_sums.max
# end

# Phase 2
def largest_contiguous_subsum(list)
  subs = subsets(list)
  max = subs.first.inject(&:+)

  subs.each do |sub|
    max = sub.inject(:+) if sub.inject(:+) > max
  end
  max
end

p largest_contiguous_subsum(list)
