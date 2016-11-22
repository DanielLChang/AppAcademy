class PolyTreeNode
  attr_accessor :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def children
    @children
  end


  def parent=(node)
    if parent.class == PolyTreeNode
      @parent.children.delete(self)
    end

    @parent = node
    if node.class == PolyTreeNode
      unless node.children.include?(self)
        node.children << self
      end
    end
  end

  def add_child(node)
    if node.class == PolyTreeNode
      node.parent = self unless node.parent == self
    end
  end

  def remove_child(node)
    raise "error" unless self.children.include?(node)
    node.parent = nil
  end

  def dfs(target)
    return self if self.value == target

    self.children.each do |child|
      current_node = child.dfs(target)
      return current_node if current_node
    end

    nil
  end

  def bfs(target)
    queue = [self]

    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target
      current_node.children.each do |child|
        queue << child
      end
    end
  end


end
