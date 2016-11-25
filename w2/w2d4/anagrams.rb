require 'byebug'

# # Phase 1
# def first_anagram?(word1, word2)
#   anagrams = word1.split('').permutation.to_a.include?(word2.split(''))
# end
#
# p first_anagram?("elvis", "lives")
# p first_anagram?("gizmo", "gizmoo")

# # Phase 2
# def second_anagram?(word1, word2)
#   word1_split = word1.split('')
#   word2_split = word2.split('')
#   # debugger
#
#   until word1_split.empty? && word2_split.empty?
#     curr_char = word2_split.index(word1_split[0])
#     return false unless curr_char
#     word1_split.delete_at(0)
#     word2_split.delete_at(curr_char)
#   end
#
#   true
# end

# p second_anagram?("gizmo", "gizmo")

# # Phase 3
# def third_anagram?(word1, word2)
#   word1.split("").sort == word2.split("").sort
# end
# p third_anagram?("cat", "act")
# p third_anagram?("gizmo", "whale")

# Phase 4
def fourth_anagram?(word1, word2)
  return false unless word1.length == word2.length
  first = Hash.new(0)
  second = Hash.new(0)
  0.upto(word1.length - 1) do |idx|
    first[word1[idx]] += 1
    second[word2[idx]] += 1
  end
  first == second
end

p fourth_anagram?("cat", "robot")
p fourth_anagram?("cat", "act")
p fourth_anagram?("gizmo", "robot")
p fourth_anagram?("gizmo", "izomg")
