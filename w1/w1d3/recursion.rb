require 'byebug'

def range(start_val, q)
  return [] if q <= start_val + 1
  arr = []
  arr << start_val + 1
  arr + range(start_val + 1, q)
end

def i_range(start_val, q)
  arr = []
  i = start_val + 1
  while i <
    arr << i
    i += 1
  end
  arr

end

def exp1(b, n)
  return 1 if n == 0

  b * exp1(b, n - 1)
end

def exp2(b, n)
  return 1 if n == 0
  return b if n == 1

  if n.even?
    base = exp2(b, n / 2)
    base * base
  else
    base = exp2(b, (n - 1) / 2)
    base * base * b
  end
end

class Array

  def deep_dup

    return self.dup if self.none? { |el| el.is_a?(Array) }

    copy = []
    self.each do |el|
      copy << el.deep_dup if el.is_a?(Array)
    end

    copy
  end

end

def fib(n)
  return [1] if n == 1
  return [1, 1] if n <= 2
  prev_num = fib(n - 1).last
  two_prev = fib(n - 2).last
  fib(n - 1) << prev_num + two_prev
end
=begin
def permutations(array)

  return [array] if array.length == 1

  result = []

  num = array.shift
  perms = permutations(array)


  perms.each do |perm|
    (0..perm.length).each do |idx|
      result << perm[0...idx] + [num] + perm[idx..-1]
    end
  end

  result

end
=end

def permutations(array)
  return array if array.length == 1
  perms = []
  array.each_index do |idx|
    # debugger
    shifted = array.rotate(idx)

    permutations(shifted[1..-1]).each do |arr|
      perms << [arr].unshift(shifted[0])
    end
  end
  perms.map(&:flatten)

end

def bsearch(array, target)
  return nil if array.empty?
  mid = array.length / 2

  if array[mid] == target
    return mid
  elsif array[mid] > target
    return bsearch(array[0...mid], target)
  else
    right = bsearch(array[mid + 1..-1], target)
    right.nil? ? nil : right + mid + 1
  end
end

def merge_sort(arr)
  return arr if arr.length <= 1
  mid = arr.length / 2
  left, right = arr[0..mid], arr[mid..-1]
  merge(merge_sort(left), merge_sort(right))
end

def merge(left, right)
  res = []
  until left.empty? || right.empty?
    if left[0] <= right[0]
      res << left.shift
    else
      res << right.shift
    end
  end
  res + left + right
end

def subsets(arr)
  return [[]] if arr.empty?
  subs = subsets(arr[0..-2])
  subs.concat(subs.map { |el| el += [arr.last] })
end

def greedy_make_change(amount, bank = [25, 10, 5, 1])
  return [amount] if bank.any? { |el| el == amount }
  change = []

  bank.each do |coin|
    if coin < amount
      change += [coin] + greedy_make_change(amount - coin, bank)
    end
    break if coin < amount
  end
  change
end

# 24, [10, 7, 1]

def make_better_change(amount, bank = [25, 10, 5, 1])
  coins = bank.select { |coin| coin <= amount }
  return nil if coins.empty?

  result = []
  coins.each do |coin|
    remainder = amount - coin
    if remainder > 0
      remainder_solution = make_better_change(remainder, coins)
      result << [coin] + remainder_solution unless remainder_solution.nil?
    else
      result << [coin]
    end
  end
  result.sort_by!(&:size).first
end
