require_relative 'graph'
require 'set'

# Implementing topological sort using both Khan's and Tarian's algorithms

# Kahn

# def topological_sort(vertices)
#   in_edge_result = {}
#   queue, sorted = [], []
#
#   vertices.each do |vertex|
#     in_edge_result[vertex] = vertex.in_edges.count
#     if vertex.in_edges.empty?
#       queue << vertex
#     end
#   end
#
#   until queue.empty?
#     vertex = queue.shift
#     sorted << vertex
#
#     vertex.out_edges.each do |edge|
#       to_vertex = edge.to_vertex
#
#       in_edge_result[to_vertex] -= 1
#
#       if in_edge_result[to_vertex] == 0
#         queue << to_vertex
#       end
#     end
#   end
#
#   sorted
# end

# Tarjan

def topological_sort(vertices)
  result = []
  seen = Set.new

  vertices.each do |vertex|
    unless seen.include?(vertex)
      depth_first_search(vertex, seen, result)
    end
  end

  result
end

def depth_first_search(vertex, seen, result)
  seen.add(vertex)

  vertex.out_edges.each do |edge|
    new_vertex = edge.to_vertex

    unless seen.include?(new_vertex)
      depth_first_search(new_vertex, seen, result)
    end
  end

  result.unshift(vertex)
end
