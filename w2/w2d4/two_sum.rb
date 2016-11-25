# # Brute force
# def bad_two_sum?(arr, target)
#   0.upto(arr.length - 2) do |idx1|
#     (idx1 + 1).upto(arr.length - 1) do |idx2|
#       return true if arr[idx1] + arr[idx2] == target
#     end
#   end
#
#   false
# end
#
# arr = [0, 1, 5, 7]
# p bad_two_sum?(arr, 8)
# p bad_two_sum?(arr, 10)

# Sorting
def okay_two_sum?(arr, target)
  arr = arr.sort
  arr.each_with_index do |num, idx|
    masked_arr = arr.take(idx) + arr.drop(idx + 1)
    return true if masked_arr.include?(target - num)
  end
  false
end
#
# p okay_two_sum?(arr, 5)
# p okay_two_sum?(arr, 10)

# Hash Map
def pair_sum?(arr, target)
  differences = Hash.new
  arr.each do |num|
    p "#{target - num} <= num | #{differences} <= differences"
    return true if differences[target - num]
    differences[num] = true
  end

  false
end

hash_array = [0, 13, 27, 14]
p pair_sum?(hash_array, 41) # true
p pair_sum?(hash_array, 8)
p pair_sum?(hash_array, 10)
