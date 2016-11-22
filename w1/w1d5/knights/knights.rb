require_relative "00_tree_node"

class KnightPathFinder
  # how thew knight moves
  MOVES = [ [-2, -1], [-2, 1], [-1, -2], [-1, 2],
            [2, 1], [2, -1], [1, 2], [1, -2] ]

  attr_accessor :start, :visited_positions, :root

  def initialize(start)
    @start = start
    @root = PolyTreeNode.new(start)
    @visited_positions = [start]
    build_move_tree
  end

  def self.valid_moves(pos)
    moves = []
    row, col = pos
    MOVES.each do |movx, movy|
      if (row + movx).between?(0, 7) && (col + movy).between?(0, 7)
        moves << [(row + movx), (col + movy)]
      end
    end
    moves
  end

  def new_move_positions(pos)
    moves = []
    KnightPathFinder.valid_moves(pos).each do |move|
      moves << move unless visited_positions.include?(move)
    end
    moves.each { |move| visited_positions << move }
    moves
  end

  #just to get array of children
  def build_move_tree
    queue = [root]

    until queue.empty?
      current_node = queue.shift
      current_position = current_node.value
      new_move_positions(current_position).each do |child|
        next_node = PolyTreeNode.new(child)
        current_node.add_child(next_node)
        queue << next_node
      end
    end

  end

  def find_path(end_pos)
    end_node = root.bfs(end_pos)

    trace_path_back(end_node)
  end

  def trace_path_back(end_node)
    path_back = []

    current_node = end_node
    until current_node.nil?
      path_back << current_node.value
      current_node = current_node.parent
    end

    path_back.reverse!
  end

end

# kpf = KnightPathFinder.new([0, 0])
# p kpf.find_path([2, 1])
